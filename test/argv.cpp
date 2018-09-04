#include <stdio.h>
int fun(int,int,int);

int fun(int x,int y,int z) {
	int a=x+y+z;
	return a;
}
int main() {
	return fun(1,2,3);
}
