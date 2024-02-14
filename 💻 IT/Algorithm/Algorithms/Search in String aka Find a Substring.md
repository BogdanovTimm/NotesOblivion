Ways to do this;

- Sliding windows - Java uses it in `"Lorem".indexOf("rem")`. But it is a slow brute force
- Boyer-Moore - fastest one. Uses space equal to alphabet
- Knuth-Morris-Pratt
- Rabin-Karp - no space. There is 2 of them:
    - Monte Carlo - it can give you the wrong answer
    - Las Vegas - always correct

![[Pasted image 20231106235015.png]]