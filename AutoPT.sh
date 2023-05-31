#!/bin/bash

# Read the target domain name from a text file
target_domain=$(cat target_domain.txt)

# Create output directory
output_dir="recon_output"
mkdir -p "$output_dir"

# Domain information
whois "$target_domain" > "$output_dir/whois.txt"
amass enum -d "$target_domain" > "$output_dir/amass.txt"

# Email addresses and users
emailfinder -d "$target_domain" > "$output_dir/emailfinder.txt"

# Metadata finder
metafinder -r "$target_domain" -o "$output_dir/metadata.txt"

# Google Dorks
dorks_hunter "$target_domain" > "$output_dir/google_dorks.txt"

# GitHub Dorks
gitdorks_go "$target_domain" > "$output_dir/github_dorks.txt"

# GitHub org analysis
enumerepo -org "$target_domain" > "$output_dir/github_org_analysis.txt"
trufflehog --regex --entropy=False -t 5 "$target_domain" > "$output_dir/trufflehog.txt"

# Subdomains
amass enum -d "$target_domain" -o "$output_dir/amass_subdomains.txt"
subfinder -d "$target_domain" -o "$output_dir/subfinder_subdomains.txt"
github-subdomains -org "$target_domain" > "$output_dir/github_subdomains.txt"

# Passive subdomain discovery
amass enum -d "$target_domain" -passive -o "$output_dir/amass_passive.txt"
subfinder -d "$target_domain" -silent -o "$output_dir/subfinder_passive.txt"
github-subdomains -org "$target_domain" -silent > "$output_dir/github_subdomains_passive.txt"

# Certificate Transparency
ctfr -d "$target_domain" > "$output_dir/ctfr_subdomains.txt"

# NOERROR subdomain discovery
dnsx -norec -l "$target_domain" > "$output_dir/dnsx_subdomains.txt"

# Bruteforce
puredns bruteforce -d "$target_domain" -w wordlist.txt > "$output_dir/bruteforce_subdomains.txt"

# Permutations
gotator -d "$target_domain" > "$output_dir/gotator_permutations.txt"
ripgen -d "$target_domain" > "$output_dir/ripgen_permutations.txt"
regulator -d "$target_domain" > "$output_dir/regulator_permutations.txt"

# JS files & Source Code Scraping
katana -d "$target_domain" -o "$output_dir/js_files.txt"

# DNS Records
dnsx -a -l "$target_domain" > "$output_dir/dns_records.txt"

# Google Analytics ID
AnalyticsRelationships -d "$target_domain" > "$output_dir/google_analytics.txt"

# TLS handshake
tlsx -d "$target_domain" > "$output_dir/tls_handshake.txt"

# Recursive search
dsieve -d "$target_domain" > "$output_dir/recursive_search.txt"

# Subdomains takeover
nuclei -t nuclei-templates/subdomain-takeover.yaml -l "$output_dir/amass_subdomains.txt" -o "$output_dir/subdomain_takeover.txt"

# DNS takeover
dnstake -d "$target_domain" > "$output_dir/dns_takeover.txt"

# DNS Zone Transfer
dig axfr @"$target_domain" > "$output_dir/dns_zone_transfer.txt"

# Cloud checkers
S3Scanner --bucket "$target_domain" > "$output_dir/s3_buckets.txt"
cloud_enum "$target_domain" > "$output_dir/cloud_resources.txt"

# Hosts
host "$target_domain" > "$output_dir/hosts.txt"

# IP info
whoisxmlapi -i "$target_domain" > "$output_dir/ip_info.txt"

# CDN checker
ipcdn "$target_domain" > "$output_dir/cdn_check.txt"

# WAF checker
wafw00f "$target_domain" > "$output_dir/waf_check.txt"

# Port Scanner
nmap -p- "$target_domain" > "$output_dir/nmap_port_scan.txt"

# Port services vulnerability checks
searchsploit --nmap "$output_dir/nmap_port_scan.txt" > "$output_dir/vulnerability_checks.txt"

# Password spraying
brutespray -f password_list.txt -U user_list.txt "$target_domain" > "$output_dir/password_spraying.txt"

# OSINT Techniques
theHarvester -d "$target_domain" -b all > "$output_dir/theharvester.txt"
recon-ng -r "$target_domain" -m recon/domains-hosts/brute_hosts > "$output_dir/recon-ng_brute_hosts.txt"

# Directory Fuzzing
ffuf -w wordlist.txt -u "$target_domain/FUZZ" > "$output_dir/directory_fuzzing.txt"

# Dorking
gsearch -d "$target_domain" > "$output_dir/dorking.txt"

# Screenshots
webscreenshot -i "$output_dir/web_probing.txt" -o "$output_dir/screenshots/"

# Nuclei scan
nuclei -t nuclei-templates/ -l "$output_dir/amass_subdomains.txt" -o "$output_dir/nuclei_scan.txt"

# Vulnerability checks
dalfox -b -o "$output_dir/xss_vulnerabilities.txt"
oralyzer -u "$target_domain" > "$output_dir/open_redirect_vulnerabilities.txt"
headers interactsh -t "$target_domain" > "$output_dir/ssrf_vulnerabilities.txt"
crlfuzz -u "$target_domain" > "$output_dir/crlf_vulnerabilities.txt"
corsy -u "$target_domain" > "$output_dir/cors_vulnerabilities.txt"
ffuf -u "$target_domain/FUZZ" -w payloads.txt -fr 'invalid' > "$output_dir/lfi_vulnerabilities.txt"
sqlmap -u "$target_domain" --batch > "$output_dir/sqli_vulnerabilities.txt"
ffuf -u "$target_domain/FUZZ" -w payloads.txt -fr 'invalid' > "$output_dir/ssti_vulnerabilities.txt"
testssl "$target_domain" > "$output_dir/ssl_tests.txt"
katana -u "$target_domain" -o "$output_dir/broken_links.txt"
ppfuzz -u "$target_domain" -o "$output_dir/prototype_pollution.txt"
Web-Cache-Vulnerability-Scanner "$target_domain" > "$output_dir/web_cache_vulnerabilities.txt"
byp4xx -l "$output_dir/amass_subdomains.txt" > "$output_dir/4xx_bypass.txt"

# DNS zone transfers
dnsrecon -d "$target_domain" -t axfr > "$output_dir/dns_zone_transfers.txt"

# Print completion message
echo "Reconnaissance completed! Output files are saved in $output_dir directory."
