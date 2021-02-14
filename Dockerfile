# FROM mcr.microsoft.com/quantum/iqsharp-base:latest
FROM mcr.microsoft.com/quantum/iqsharp-base:0.15.2101125897
USER root
WORKDIR /app
ADD . /app
COPY . /app

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN echo "export PATH=\"\$PATH:\$HOME/.dotnet/tools\"" >> ~/.bash_profile
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade setuptools
RUN pip3 install -r /app/requirements.txt
RUN dotnet iqsharp install

# streamlit-specific commands
RUN mkdir -p ~/.streamlit
RUN bash -c 'echo -e "\
[general]\n\
email = \"\"\n\
" > ~/.streamlit/credentials.toml'

RUN bash -c 'echo -e "\
[server]\n\
enableCORS = false\n\
" > ~/.streamlit/config.toml'

# exposing default port for streamlit
EXPOSE 8501

COPY . .
RUN export PATH="$HOME/.local/bin:${PATH}"
CMD python -m streamlit run qrng_final.py --server.enableCORS false --server.enableXsrfProtection false --server.port $PORT