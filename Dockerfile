# Use an official Ubuntu runtime as a parent image
FROM ubuntu:latest

# Set the working directory in the container to /app
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    libgl1-mesa-dev \
    libxi6 \
    libxrender1 \
    libxkbcommon0 \
    libsm6 \
    libxext6 \
    libfontconfig1 \
    libx11-xcb1 \
    libxcb-dri3-0 \
    libxcb-xinerama0 \
    libxcb1 \
    libxau6 \
    libxdmcp6 \
    libxcb-dri2-0 \
    libxcb-xfixes0 \
    libxcb-present0 \
    libxcb-sync1 \
    libxshmfence1 \
    libxxf86vm1 \
    libglu1-mesa \
    libxrandr2 \
    libxinerama1 \
    libxcursor1 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Download and extract Blender
RUN wget https://download.blender.org/release/Blender3.6/blender-3.6.8-linux-x64.tar.xz \
    && tar -xf blender-3.6.8-linux-x64.tar.xz \
    && rm blender-3.6.8-linux-x64.tar.xz \
    && mv blender-3.6.8-linux-x64 blender

# Set the PATH to include Blender
ENV PATH="/app/blender:${PATH}"

# Copy the current directory contents into the container at /app
COPY . /app

# Install pipenv and any needed packages specified in Pipfile
RUN pip3 install pipenv \
    && pipenv install --system --deploy

# Set the PYTHONPATH to the location of the system Python packages
ENV PYTHONPATH="/usr/local/lib/python3.8/site-packages:${PYTHONPATH}"

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Run app.py when the container launches
CMD ["python3", "app.py"]
