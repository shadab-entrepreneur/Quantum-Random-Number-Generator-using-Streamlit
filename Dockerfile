FROM mcr.microsoft.com/quantum/iqsharp-base:latest
WORKDIR /app
ADD . /app
COPY . /app

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# streamlit-specific commands
RUN mkdir -p /app/.streamlit
RUN bash -c 'echo -e "\
[general]\n\
email = \"\"\n\
" > /app/.streamlit/credentials.toml'

RUN bash -c 'echo -e "\
[server]\n\
enableCORS = false\n\
" > /app/.streamlit/config.toml'

# exposing default port for streamlit
EXPOSE 8501

RUN pip3 install --upgrade pip
RUN pip3 install --upgrade setuptools
RUN pip3 install -r /app/requirements.txt
COPY . .
RUN export PATH="$HOME/.local/bin:${PATH}"
CMD python -m streamlit run qrng_final.py --server.enableCORS false