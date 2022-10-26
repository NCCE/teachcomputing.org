FROM ruby:3.1.2-alpine
RUN apk update
RUN apk --no-cache add curl build-base postgresql-dev tzdata nodejs chromium chromium-chromedriver python3 python3-dev py3-pip yarn git procps less bash
RUN pip install --upgrade pip
RUN pip3 install -U selenium
RUN mkdir -p /app/node_modules
RUN echo "parse_git_branch() {" >> ~/.bashrc
RUN echo "   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'" >> ~/.bashrc
RUN echo "}" >> ~/.bashrc
RUN echo "" >> ~/.bashrc
RUN echo 'PS1="\u@\h \[\033[32m\]\w -\$(parse_git_branch)\[\033[00m\] $ "' >> ~/.bashrc
RUN echo "" >> ~/.bashrc
RUN echo "[[ -f ~/.bashrc ]] && source ~/.bashrc" >> ~/.bash_profile
WORKDIR /app
