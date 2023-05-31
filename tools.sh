#!/bin/bash

# Update system packages
sudo apt update

# Install necessary dependencies
sudo apt install -y git python3 python3-pip nmap

# Install Go
curl -sSL https://dl.google.com/go/go1.17.1.linux-amd64.tar.gz | sudo tar -C /usr/local -xzf -
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc

# Clone necessary repositories
git clone https://github.com/OWASP/Amass.git
git clone https://github.com/anshumanbh/git-all-secrets.git
git clone https://github.com/projectdiscovery/subfinder.git
git clone https://github.com/projectdiscovery/nuclei.git

# Install Go tools
cd Amass && go install ./... && cd ..
cd git-all-secrets && pip3 install -r requirements.txt && cd ..
cd subfinder/v2/cmd/subfinder && go build && mv subfinder /usr/local/bin/ && cd ../../../..
cd nuclei/v2/cmd/nuclei && go build && mv nuclei /usr/local/bin/ && cd ../../../..

# Install other tools
pip3 install emailfinder
pip3 install metafinder
pip3 install dalfox
pip3 install waybackurls
pip3 install ffuf
pip3 install gf
git clone https://github.com/1ndianl33t/Gf-Patterns.git
mv Gf-Patterns/*.json ~/.gf

# Install additional tools from GitHub repositories
go get github.com/michenriksen/aquatone
go get github.com/tomnomnom/assetfinder
go get github.com/projectdiscovery/httpx/cmd/httpx
go get github.com/projectdiscovery/unimap/cmd/unimap
go get github.com/hakluke/hakrawler
go get github.com/hahwul/dalfox
go get github.com/projectdiscovery/shuffledns/cmd/shuffledns
go get github.com/ffuf/ffuf
go get github.com/hahwul/dalfox/v2
go get github.com/m4dm0e/eyeWitness
go get github.com/tomnomnom/waybackurls
go get github.com/tomnomnom/qsreplace
go get github.com/tomnomnom/gf
go get github.com/ffuf/gf

# Install additional tools from package managers
sudo apt install -y whois dnsutils wget curl jq

# Install CMS Scanner
git clone https://github.com/Tuhinshubhra/CMSeeK.git
cd CMSeeK && pip3 install -r requirements.txt && cd ..

# Install SSL tests tool
git clone https://github.com/drwetter/testssl.sh.git

# Install web cache vulnerabilities scanner
git clone https://github.com/knownsec/cachetool.git

# Install S3Scanner
git clone https://github.com/sa7mon/S3Scanner.git

# Install cloud_enum
git clone https://github.com/initstring/cloud_enum.git

# Install IP CDN checker
pip3 install ipcdn

# Install WAF checker
pip3 install wafw00f

# Install Favicon Real IP
go get github.com/hahwul/fav-up

# Install JS files & Source Code Scraping tool
go get github.com/Emoe/katanero

# Install Password spraying tool
git clone https://github.com/x90skysn3k/brutespray.git

# Install XSS tool
go get github.com/hahwul/dalfox

# Install Open redirect tool
go get github.com/0x4287/Oralyzer

# Install SSRF tool
go get github.com/leobeosab/sharptools

# Install CRLF tool
go get github.com/dwisiswant0/crlfuzz

# Install CORS tool
go get github.com/saeeddhqan/corsy

# Install LFI tool
go get github.com/ffuf/ffuf

# Install SQLi tool
sudo apt install -y sqlmap

# Install SSTI tool
go get github.com/ffuf/ffuf

# Install Broken Links Checker tool
go get github.com/Emoe/katanero

# Install Prototype Pollution tool
go get github.com/pwntester/ppfuzz

# Install 4XX Bypasser tool
go get github.com/lobuhi/byp4xx

# Install additional tools from searchsploit
searchsploit --update

# Print completion message
echo "Tool installation completed!"

#!/bin/bash

# Install required tools
apt-get update
apt-get install -y subfinder amass emailfinder metafinder gitdorks enumerepo trufflehog github-subdomains ctfr dnsx puredns gotator ripgrep theharvester recon-ng ffuf gsearch webscreenshot nuclei dalfox oralyzer headers crlfuzz corsy sqlmap testssl katana ppfuzz wafw00f Web-Cache-Vulnerability-Scanner bypass dnsrecon

# Download wordlist
wget https://github.com/danielmiessler/SecLists/raw/master/Discovery/DNS/ark_subdomains_top100000.txt -O wordlist.txt

echo "Installation completed."
