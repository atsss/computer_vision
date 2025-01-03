FROM python:3.13-slim as build

# Copy requirements.txt first for better cache on later pushes
COPY requirements.txt requirements.txt

ENV PATH=/root/.local/bin:$PATH

RUN pip install --upgrade pip

# Install project requirements
RUN pip install --user -r requirements.txt

FROM python:3.13-slim

WORKDIR /usr/src

COPY --from=build /root/.local/ /root/.local/

# Set the imported python dependencies on PATH
ENV PATH=/root/.local/bin:$PATH

COPY . ./

CMD ["bash"]
