#!/bin/bash

# Verifica se a ferramenta libreoffice esta instalada:
libreoffice --version > /dev/null
if [[ $? -ne 0 ]]; 
then
	echo "libreoffice is not installed. Exiting..."
	exit
fi

# Declaracoes:
target=$HOME/Convert-To-PDF
servname=convert-to-pdf

# Cria o diretorio-alvo (Onde os arquivos serao convertidos):
mkdir -p $target

# Cria o arquivo .path:
echo "
[Path]
PathChanged=$target

[Install]
WantedBy=multi-user.target

" > $servname.path


# Cria o arquivo .service:
echo "
[Service]
Type= simple
ExecStart=/bin/bash -c 'libreoffice --headless --convert-to pdf *.docx . && libreoffice --headless --convert-to pdf *.doc .'
WorkingDirectory=$target
User=$USER

" >> $servname.service

# Ativa o Servico:
sudo mv ./$servname.* /etc/systemd/system/.
sudo systemctl daemon-reload
sudo systemctl enable --now $servname.path

systemctl status convert-to-pdf.path
systemctl status convert-to-pdf.service
