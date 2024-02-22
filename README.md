# Blender Flask API

This is a Flask API that interacts with the Blender Python API. It allows you to run Python code in Blender and retrieve or delete files from the Docker container.

## Endpoints

### `/run`

- Method: POST
- Description: Runs Python code in Blender.
- Data Params: Python code (as raw text in the request body)
- Success Response: A JSON object with a `message` field set to 'success' and a `stdout` field containing the output from Blender.
- Error Response: A JSON object with a `message` field set to 'error' and a `stdout` field containing the output from Blender.
- Example: 

```bash
curl -X POST -F "file=@script.py" http://localhost:5000/run
```

### `/retrieve`

- Method: GET
- Description: Retrieves a file from the Docker container.
- URL Params: `path=[string]` (the path to the file in the Docker container)
- Success Response: The requested file.
- Example: 

```bash
curl -X GET "http://10.0.0.42:5001/retrieve?path=/app/moon.png" > moon.png
```

### `/delete`

- Method: DELETE
- Description: Deletes a file from the Docker container.
- URL Params: `path=[string]` (the path to the file in the Docker container)
- Success Response: A JSON object with a `message` field set to 'File deleted.'
- Error Response: A JSON object with a `message` field set to 'File not found.'
- Example: 

```bash
curl -X DELETE "http://localhost:5000/delete?path=/app/script.py"
```

### `/documentation`

- Method: GET
- Description: Returns the API documentation.
- Success Response: The API documentation.
- Example: 

```bash
curl -X GET http://localhost:5000/documentation
```

## Docker

To build the Docker image, use the following command:

```bash
docker build -t blender-flask-app .
```

To run the Docker container, use the following command:

```bash
docker run -p 5000:5000 blender-flask-app
```
