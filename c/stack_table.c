#include <stdio.h>

int main() {
  long long long_long1 = 123;
  long long long_long2 = -456;
  unsigned int uint1 = 789;
  unsigned int uint2 = 0;
  char chars[5] = "FOUR";
  float floaty = 1.23456;
  printf("%12s%12s%14s%12s\n", "Name", "Value", "Size", "Adress");
  printf("%12s%12lld%14ld%16p\n", "long_long1", long_long1, sizeof(long_long1), &long_long1);
  printf("%12s%12lld%14ld%16p\n", "long_long2", long_long2, sizeof(long_long2), &long_long2);
  printf("%12s%12d%14ld%16p\n", "uint1", uint1, sizeof(uint1), &uint1);
  printf("%12s%12d%14ld%16p\n", "uint2", uint2, sizeof(uint2), &uint2);
  printf("%12s%12s%14ld%16p\n", "chars", chars, sizeof(chars), &chars);
  printf("%12s%12f%14ld%16p\n", "floaty", floaty, sizeof(floaty), &floaty);
  return 0;
}
