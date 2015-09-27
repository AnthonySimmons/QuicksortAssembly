#include <iostream>
#include "stdlib.h"

using std::cin;
using std::cout;
using std::endl;

int A[] = {7,0,1,2,5,4,9,8,3,6};
int B[] = {42,44,742,8,39,32,1,6,85,3,8,42,21};
int C[] = {5,4,3,2,1};

void print(void)
{
	for(int i = 0; i < 10; i++)
	{
		cout<<A[i]<<" ";
	}
	cout<<endl<<endl;
}
void swap(int *one, int *two)
{
	//cout<<"One: "<<*one<<endl;
	//cout<<"Two: "<<*two<<endl;
	print();
	int tmp = *one;
	*one = *two;
	*two = tmp;
}
int* Partition(int *lo, int *hi, int *jr)
{
	int *i = lo;
	int *j = hi;
	if(hi - lo < 1)
	{
		return lo;
	}
	
	int PV = *hi;
	
	j -= 1;
	while(i <= j)
	{
		//cout<<"PV: "<<PV<<endl;
		//print();
		while(*i < PV)
		{
			i += 1;
		}
		while(*j > PV)
		{
			j -= 1;
		}
		if(i <= j)
		{
			swap(i, j);
			i += 1;
			j -= 1;
		}
		
		//system("Pause");
	}
	swap(i, hi);
	jr = j;
	//cout<<"*i: "<<*i<<endl;
	//cout<<"*j: "<<*j<<endl;
	return i;
	//$v0 -> lo+4
	//$v1 -> hi-4
}
void quicksort(int *A, int length)
{
	int j = 0;
	if(length > 1)
	{
		//system("Pause");
		int *x = Partition(A, A+length-1, &j);
		//cout<<"*X: "<<*x<<endl;
		//if (left < index - 1)
		//if(A < x-1)
		{
			quicksort(A, x-A);	
		}
		//if (index < right)
		//if(x < A+length-1)
		{
			quicksort(x+1, A+length-x-1);
		}
	}
	// |0|1|2|3|4|5|6|
	//  A	  x
}

int main(void)
{

	quicksort(A, 10);
	//system("Pause");
	//quicksort(A, 10);
	//Partition(&A[0], &A[6]);
	//quickSort(A, 0, 9);
	print();
	

	system("Pause");
}