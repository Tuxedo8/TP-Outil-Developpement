#include <stdio.h>
#include <stdlib.h>

unsigned long fibonacci_rec(unsigned long n) {
  if (n < 2)
    return n;
  else
    return fibonacci_rec(n-1) + fibonacci_rec(n-2);
}

unsigned long fibonacci_lin(unsigned long n) {
  long fib_prec = 0;
  long fib_curr = 1;
  for (int i=2; i<=n; i++) {
    long fib_next = fib_prec + fib_curr;
    fib_prec = fib_curr;
    fib_curr = fib_next;
  }
  return fib_curr;
}

int main(int argc, char *argv[]) {
  unsigned int n = 0;
  if (argc > 1) {
    n = (unsigned int) atoi(argv[1]);
  }
#ifdef __GNUC__
#ifdef __clang__
  printf("Fibonacci(%u): %lu\n", n, fibonacci_lin(n));
#else
  printf("Fibonacci(%u): %lu\n", n, fibonacci_rec(n));
#endif
#else
  fprintf(stderr, "Compilateur non géré\n");
#endif
}
