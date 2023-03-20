#include <stdio.h>
#include <stdlib.h>

int main()
{
  float arr[] = {0.897, 0.565, 0.656, 0.1234, 0.665, 0.3434, 0.1126, 0.554, 0.3349, 0.678, 0.3656, 0.9989};
  int n = sizeof(arr) / sizeof(arr[0]);
  const int BUCKET_SIZE = 10;

  // Allocate memory for the buckets
  int i, j, k;
  int count[10];
  float *bucket[10];
  for (i = 0; i < BUCKET_SIZE; i++)
  {
    count[i] = 0;
    bucket[i] = (float *)malloc(n * sizeof(float));
  }

  // Assign values to the buckets
  for (i = 0; i < n; i++)
  {
    int bucket_index = (int)(arr[i] * BUCKET_SIZE);
    bucket[bucket_index][count[bucket_index]++] = arr[i];
  }

  // Sort the buckets using insertion sort
  for (i = 0; i < BUCKET_SIZE; i++)
  {
    for (j = 1; j < count[i]; j++)
    {
      float temp = bucket[i][j];
      k = j - 1;
      while (k >= 0 && bucket[i][k] > temp)
      {
        bucket[i][k + 1] = bucket[i][k];
        k--;
      }
      bucket[i][k + 1] = temp;
    }
  }

  // Merge the buckets back into the original array
  int index = 0;
  for (i = 0; i < BUCKET_SIZE; i++)
  {
    for (j = 0; j < count[i]; j++)
    {
      arr[index++] = bucket[i][j];
    }
  }

  // Free memory used by the buckets
  for (i = 0; i < BUCKET_SIZE; i++)
  {
    free(bucket[i]);
  }

  printf("Sorted array: ");
  for (int i = 0; i < n; i++)
  {
    printf("%f ", arr[i]);
  }
  printf("\n");

  return 0;
}