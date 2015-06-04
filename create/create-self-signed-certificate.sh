pri_key=${pri_key:-server.key} # Private Key
csr=${csr:-server.csr} # Certificate Signing Request
crt=${crt:-server.crt} # Certificate

# Create Private Key
openssl genrsa 2048 > $pri_key

# Create CSR from Private Key
# "-key" option does offer public key from private key.
openssl req -new -key $pri_key > $csr

# Create CRT signed by own private key
openssl x509 -days 3650 -req -signkey $pri_key < $csr > $crt
