
if not exist python (
    curl -L -C - https://www.python.org/ftp/python/3.11.3/python-3.11.3-embed-amd64.zip -o py.zip
    mkdir python
    tar -xf py.zip -C python
    del py.zip
)
.\python\python.exe -m http.server --directory . 