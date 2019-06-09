#include<stdio.h>
#include "calculate.h"

int main(int argc, char* argv[])
{
  if(argc != 2)
  {
    printf("Usage: ./calculate Input_file\n");
    return -1;
  }
  FILE* file = fopen(argv[1],"r");
  if(file == NULL)
  {
    printf("Unable to open input file\n");
    return -1;
  }
  double a=0,b=0,ans=0;
  char op;
  while(!feof(file))
  {
    fscanf(file,"%lf %c %lf\n",&a,&op,&b);
    if(op == '+')
    {
      ans = add(a,b);
      printf("%lf + %lf = %lf\n",a,b,ans);
    }
    else if(op == '-')
    {
      ans = subtract(a,b);
      printf("%lf - %lf = %lf\n",a,b,ans);
    }
    else if(op == '*')
    {
      ans = multiply(a,b);
      printf("%lf * %lf = %lf\n",a,b,ans);
    }
    else if(op == '/')
    {
      if(b == 0)
      {
        printf("Invalid Division by Zero!\n");
        continue;
      }
      ans = divide(a,b);
      printf("%lf / %lf = %lf\n",a,b,ans);
    }
    else
    {
      printf("Invalid Operation %c \n",op);
    }
  }
  fclose(file);
  return 0;
}
