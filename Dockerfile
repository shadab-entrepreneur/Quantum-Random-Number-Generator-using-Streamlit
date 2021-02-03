FROM mcr.microsoft.com/quantum/iqsharp-base:latest
WORKDIR /app
ADD . /app
COPY . /app


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
# RUN curl -O https://svn.apache.org/repos/asf/oodt/tools/oodtsite.publisher/trunk/distribute_setup.py
# RUN /usr/local/bin/python distribute_setup.py
# RUN /usr/local/bin/python/easy_install pip

RUN export PATH="$HOME/.local/bin:${PATH}"
RUN /usr/local/bin/pip install --upgrade pip
RUN /usr/local/bin/pip install -r /app/requirements.txt --upgrade --ignore-installed

CMD ["streamlit", "run", "qrng_final.py"]
