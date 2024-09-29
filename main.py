import os

import uvicorn
from fastapi import FastAPI, UploadFile, File
from fastapi.responses import StreamingResponse
from pydantic import BaseModel
from io import BytesIO
import torch
from transformers import pipeline
from moviepy.editor import VideoFileClip
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from reportlab.lib.units import inch
import pdfplumber
import google.generativeai as genai
import markdown
import pdfkit


path_wkhtmltopdf = r"C:\Program Files\wkhtmltopdf\bin\wkhtmltopdf.exe"  # Update with your actual path
config = pdfkit.configuration(wkhtmltopdf=path_wkhtmltopdf)

os.environ['HF_HOME'] = r'D:\ttt24\pythonProject1\model'
# Initialize FastAPI app
app = FastAPI()

# Set up Gemini API
os.environ["GEMINI_API_KEY"] = 'AIzaSyCCxLU30c2Z4yy8nLwrDvSc8RCUCN07h5w'
genai.configure(api_key=os.environ["GEMINI_API_KEY"])

generation_config = {
    "temperature": 1,
    "top_p": 0.95,
    "top_k": 64,
    "max_output_tokens": 8192,
    "response_mime_type": "text/plain",
}

model = genai.GenerativeModel(
    model_name="gemini-1.5-flash",
    generation_config=generation_config,
)

# Function to extract audio from video
def extract_audio_from_video(video_path: str, audio_output_path: str):
    video = VideoFileClip(video_path)
    video.audio.write_audiofile(audio_output_path)

# Function for speech to text conversion
# Function for speech to text conversion
def speech_to_text(audio_path: str):
    asr = pipeline("automatic-speech-recognition", model="openai/whisper-base")
    transcription = asr(audio_path, return_timestamps=True)  # Enable long-form generation
    return transcription['text']


# Function to generate PDF from transcription
def generate_pdf_from_transcription(transcription: str, output_pdf_path: str):
    c = canvas.Canvas(output_pdf_path, pagesize=letter)
    width, height = letter

    # Define margins and available width for text
    left_margin = 1 * inch
    right_margin = 1 * inch
    top_margin = 1 * inch
    bottom_margin = 1 * inch
    available_width = width - (left_margin + right_margin)
    available_height = height - (top_margin + bottom_margin)

    # Add title on the first page
    c.setFont("Helvetica-Bold", 14)
    c.drawString(left_margin, height - top_margin, "Transcription:")

    # Move cursor down to start the transcription below the title
    text_object = c.beginText(left_margin, height - top_margin - 30)
    text_object.setFont("Helvetica", 10)

    # Set up text rendering with soft wrapping
    def soft_wrap_text(text, available_width):
        wrapped_lines = []
        words = text.split()  # Split text into words
        current_line = ""

        for word in words:
            if c.stringWidth(current_line + word, "Helvetica", 10) < available_width:
                current_line += word + " "
            else:
                wrapped_lines.append(current_line.strip())
                current_line = word + " "
        if current_line:
            wrapped_lines.append(current_line.strip())

        return wrapped_lines

    # Function to handle adding new pages when needed
    def add_page():
        nonlocal text_object
        c.drawText(text_object)
        c.showPage()  # Add a new page
        c.setFont("Helvetica", 10)
        text_object = c.beginText(left_margin, height - top_margin)

    lines = transcription.split('\n')
    for line in lines:
        wrapped_lines = soft_wrap_text(line, available_width)
        for wrapped_line in wrapped_lines:
            if text_object.getY() <= bottom_margin:  # Check if we've reached the bottom margin
                add_page()
            text_object.textLine(wrapped_line)

    # Finalize the PDF
    c.drawText(text_object)
    c.save()

# Function to extract text from a PDF file
def extract_text_from_pdf(pdf_path: str):
    with pdfplumber.open(pdf_path) as pdf:
        text = ''
        for page in pdf.pages:
            text += page.extract_text()
    return text

# Function to generate summary and MCQs
def generate_summary(text: str):
    chat_session = model.start_chat(history=[])
    prompt = f"Prepare complete Notes from the given text which can be helpful for exam. Use proper spacing and no bold or italics. After it generate 5 MCQ questions from it, formatted in plain text without special formatting: {text}"
    response = chat_session.send_message(prompt)

    if hasattr(response, 'text'):
        return response.text
    else:
        print("Failed to generate summary. Response:", response)
        return None



@app.post("/process_video/")
async def process_video(file: UploadFile = File(...)):
    # Save the uploaded video file
    video_path = f"{file.filename}"
    with open(video_path, "wb") as f:
        f.write(await file.read())

    # Step 1: Extract audio
    audio_output_path = "./tmp/output_audio.wav"
    extract_audio_from_video(video_path, audio_output_path)

    # Step 2: Convert audio to text
    transcription = speech_to_text(audio_output_path)

    # Step 3: Generate PDF from transcription
    pdf_transcription_path = "./tmp/transcription.pdf"
    generate_pdf_from_transcription(transcription, pdf_transcription_path)

    # Step 4: Generate summary and MCQs
    summary = generate_summary(transcription)
    if summary:
        summary_pdf_path = "./tmp/summary.pdf"
        html_content = markdown.markdown(summary)
        pdfkit.from_string(html_content, summary_pdf_path,  configuration=config)

        # generate_pdf_from_transcription(summary, summary_pdf_path)

        # Return the summary PDF as a response
        with open(summary_pdf_path, "rb") as pdf_file:
            pdf_output = BytesIO(pdf_file.read())

            pdf_output.seek(0)  # Move to the beginning of the BytesIO buffer
            return StreamingResponse(pdf_output, media_type='application/pdf', headers={"Content-Disposition": "attachment; filename=summary.pdf"})
    else:
        return {"error": "Failed to generate summary."}

# You can run the FastAPI app using Uvicorn
uvicorn.run(app, host="192.168.113.93", port=8000)
