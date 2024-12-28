FROM python:3.13 as build

# Copy requirements.txt first for better cache on later pushes
COPY requirements.txt requirements.txt

ENV PATH=/root/.local/bin:$PATH

RUN pip install --upgrade pip

# Install project requirements
RUN pip install --user -r requirements.txt

FROM python:3.13

# Install dependencies, including graphics libraries
RUN apt-get update &&  apt-get install -y python3-opencv

WORKDIR /app

COPY --from=build /root/.local /root/.local

# Set the imported python dependencies on PATH
ENV PATH=/root/.local/bin:$PATH

COPY . ./

CMD ["bash"]
