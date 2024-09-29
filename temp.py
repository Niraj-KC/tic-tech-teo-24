import requests

ngrok_url = "http://127.0.0.1:8000/process_video/"
video_file_path = r"D:\JISHAN\Downloads\test_video.mp4"
output_pdf_path = r"D:\JISHAN\Downloads\output_file_lh.pdf"  # Path to save the PDF file

with open(video_file_path, "rb") as video_file:
    response = requests.post(ngrok_url, files={"file": video_file})

    # Check if the response is OK
    if response.status_code == 200:
        # Save the PDF content
        with open(output_pdf_path, "wb") as pdf_file:
            pdf_file.write(response.content)
        print(f"PDF saved successfully to {output_pdf_path}")
    else:
        print(f"Failed to process video. Status Code: {response.status_code}")
        print("Response Content:", response.content)
