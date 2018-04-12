def generate_key(bits):
    p=random_prime(2**(bits//2),lbound=2**(bits//2-1))
    q=random_prime(2**(bits//2),lbound=2**(bits//2-1))
    N=p*q
    Euler_N=(q-1)*(p-1)
    e=randint(1,Euler_N)
    while(gcd(e,Euler_N)!=1):
	e=randint(1,Euler_N)
    d=inverse_mod(e,Euler_N)
    return e,d,N

def encode(m):
    message=str(m)
    return sum(ord(message[i])*pow(256,i) for i in range(len(message)))

def decode(n):
    message=""
    while(n>0):
	message+=chr(n%256)
	n=n//256
    return message

def encrypt(m,e,N):
    return lift(mod(m,N)**e)

def decrypt(n,d,N):
    return lift(mod(n,N)**d)

e,d,N=generate_key(1024) 
encode_m=encode('RSA')  
encrypt_n=encrypt(encode_m,e,N)
decrypt_n=decrypt(encrypt_n,d,N)
decode_m=decode(decrypt_n)
signature=encrypt(encode_m,d,N)
Verify=decrypt(signature,e,N)
print decode_m
