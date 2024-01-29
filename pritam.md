## ASSIGNMENT

### Question 3
```python3
n = int(input("Enter value of n: "))
x = int(input("Enter value of x: "))

a = 2
sum_a = 0
while a <= n:
   sum_a += a**x
   a += 2


print("Value:", sum_a)
```
#### Output
```
Enter value of n: 10
Enter value of x: 3
Value: 1800
```

### Question 4
```python3
X = [43, 54, 115, -23, 45, 0, -48]

for i in range(len(X)):
   # find smallest element
   min = i
   for j in range(i+1, len(X)):
       if X[j] < X[min]:
           min = j
   # swap
   X[i], X[min] = X[min], X[i]

print(X)
```
#### Output
```
[-48, -23, 0, 43, 45, 54, 115]
```

### Question 5
```python3
n = int(input("Enter value of n: "))
fact = 1
for i in range(n,1,-1):
   fact *= i
print(f"{n}! = {fact}")
```
#### Output
```
Enter value of n: 5
5! = 120
```

### Question 6
```python3
def isPrime(n):
    p = int(n**0.5)+1
    for i in range(2, p):
        if n % i == 0: return False
    return True

primes = []
for i in range(1, 1001):
    if isPrime(i):
        primes.append(i)

print(primes)
```
#### Output
```
[1, 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251,
 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563,
 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881,
883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997]
```
