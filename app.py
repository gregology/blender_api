from flask import Flask, request, send_file, jsonify
import subprocess
import os
import platform

app = Flask(__name__)

@app.route('/run', methods=['POST'])
def run_code():
    file = request.files['file']
    file.save('script.py')

    if platform.system():
        blender_command = [
            '/Applications/Blender.app/Contents/MacOS/Blender',
            '--background',
            '--gpu-backend',
            'metal',
            '--python',
            'script.py'
        ]
    else:
        blender_command = ['blender', '--background', '--python', 'script.py']


    result = subprocess.run(
        blender_command,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT
    )
    message = 'success' if result.returncode == 0 else 'error'
    status_code = 200 if result.returncode == 0 else 400
    return jsonify({
        'message': message,
        'stdout': result.stdout.decode()
    }), status_code

@app.route('/retrieve', methods=['GET'])
def retrieve_file():
    file_path = request.args.get('path')
    return send_file(file_path)

@app.route('/delete', methods=['DELETE'])
def delete_file():
    file_path = request.args.get('path')
    if os.path.exists(file_path):
        os.remove(file_path)
        return jsonify({'message': 'File deleted.'}), 200
    else:
        return jsonify({'message': 'File not found.'}), 404

@app.route('/documentation', methods=['GET'])
def documentation():
    return 'API Documentation: ...'  # Replace with your actual documentation

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)