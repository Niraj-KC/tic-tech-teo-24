# import os
# import uvicorn
# from fastapi import FastAPI, UploadFile, File
# from fastapi.responses import JSONResponse
# from sentence_transformers import SentenceTransformer, util
# import pdfplumber
#
# # Initialize FastAPI app
# app = FastAPI()
#
# # Load a pre-trained Sentence-BERT model for Semantic Textual Similarity
# model = SentenceTransformer('sentence-transformers/all-mpnet-base-v2')
#
#
# # Function to extract text from a PDF file
# def extract_text_from_pdf(pdf_path: str) -> str:
#     with pdfplumber.open(pdf_path) as pdf:
#         text = ''
#         for page in pdf.pages:
#             page_text = page.extract_text()
#             if page_text:
#                 text += page_text
#     return text
#
#
# @app.post("/compare_answers/")
# async def compare_answers(reference_file: UploadFile = File(...), student_file: UploadFile = File(...)):
#     # Save the uploaded PDF files
#     reference_path = f"./tmp/reference_answer.pdf"
#     student_path = f"./tmp/student_answer.pdf"
#
#     with open(reference_path, "wb") as f:
#         f.write(await reference_file.read())
#
#     with open(student_path, "wb") as f:
#         f.write(await student_file.read())
#
#     # Step 1: Extract text from both PDFs
#     reference_answer = extract_text_from_pdf(reference_path)
#     student_answer = extract_text_from_pdf(student_path)
#
#     # Step 2: Encode both answers to get their embeddings
#     reference_embedding = model.encode(reference_answer, convert_to_tensor=True)
#     student_embedding = model.encode(student_answer, convert_to_tensor=True)
#
#     # Step 3: Compute the cosine similarity between the embeddings
#     similarity_score = util.pytorch_cos_sim(reference_embedding, student_embedding).item()
#
#     # Define a threshold for similarity
#     threshold = 0.8
#     if similarity_score >= threshold:
#         result = {
#             "similarity_score": similarity_score,
#             "message": "The student's answer is sufficiently similar to the reference answer."
#         }
#     else:
#         result = {
#             "similarity_score": similarity_score,
#             "message": "The student's answer is not sufficiently similar to the reference answer."
#         }
#
#     # Return the similarity score and message as a JSON response
#     return JSONResponse(content=result)
#
#
# # You can run the FastAPI app using Uvicorn
# if __name__ == "__main__":
#     uvicorn.run(app, host="192.168.113.93", port=8005)


import os
import uvicorn
import requests
from fastapi import FastAPI
from fastapi.responses import JSONResponse
from sentence_transformers import SentenceTransformer, util
import pdfplumber

# Initialize FastAPI app
app = FastAPI()

# Load a pre-trained Sentence-BERT model for Semantic Textual Similarity
model = SentenceTransformer('sentence-transformers/all-mpnet-base-v2')


# Function to extract text from a PDF file
def extract_text_from_pdf(pdf_path: str) -> str:
    with pdfplumber.open(pdf_path) as pdf:
        text = ''
        for page in pdf.pages:
            page_text = page.extract_text()
            if page_text:
                text += page_text
    return text


# Function to download a file from a URL
def download_pdf(url: str, save_path: str):
    response = requests.get(url)
    with open(save_path, 'wb') as f:
        f.write(response.content)


@app.post("/compare_answers/")
async def compare_answers(reference_url: str, student_url: str):
    # Save the downloaded PDF files
    print(reference_url, student_url)

    reference_path = "./tmp/reference_answer.pdf"
    student_path = "./tmp/student_answer.pdf"

    # Step 1: Download the PDFs from the given URLs
    download_pdf(reference_url, reference_path)
    download_pdf(student_url, student_path)

    # Step 2: Extract text from both PDFs
    reference_answer = extract_text_from_pdf(reference_path)
    student_answer = extract_text_from_pdf(student_path)

    # Step 3: Encode both answers to get their embeddings
    reference_embedding = model.encode(reference_answer, convert_to_tensor=True)
    student_embedding = model.encode(student_answer, convert_to_tensor=True)

    # Step 4: Compute the cosine similarity between the embeddings
    similarity_score = util.pytorch_cos_sim(reference_embedding, student_embedding).item()

    # Define a threshold for similarity
    threshold = 0.8
    if similarity_score >= threshold:
        result = {
            "similarity_score": similarity_score,
            "message": "The student's answer is sufficiently similar to the reference answer."
        }
    else:
        result = {
            "similarity_score": similarity_score,
            "message": "The student's answer is not sufficiently similar to the reference answer."
        }

    # Return the similarity score and message as a JSON response
    return JSONResponse(content=result)


# You can run the FastAPI app using Uvicorn
if __name__ == "__main__":
    uvicorn.run(app, host="192.168.113.93", port=8005)
