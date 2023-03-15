#include <stdio.h>
#include <stdlib.h>

#define ARRAY_SIZE 10

void printArray(float arr[], int n)
{
  for (int i = 0; i < n; i++)
  {
    printf("%f ", arr[i]);
  }
  printf("\n");
}

void bucketSort(float arr[], int n)
{
  // Create an array of empty buckets
  int num_buckets = 10;
  float buckets[10][ARRAY_SIZE];

  // Initialize each bucket as empty
  for (int i = 0; i < num_buckets; i++)
  {
    for (int j = 0; j < ARRAY_SIZE; j++)
    {
      buckets[i][j] = 0.0f;
    }
  }

  // Assign each element to its corresponding bucket
  for (int i = 0; i < n; i++)
  {
    int bucket_index = (int)(arr[i] * num_buckets);
    int j = 0;
    while (j < ARRAY_SIZE && buckets[bucket_index][j] != 0.0f)
    {
      j++;
    }
    if (j < ARRAY_SIZE)
    {
      buckets[bucket_index][j] = arr[i];
    }
    else
    {
      printf("Bucket overflow error\n");
      exit(1);
    }
  }

  // Sort each bucket using insertion sort
  for (int i = 0; i < num_buckets; i++)
  {
    for (int j = 1; j < ARRAY_SIZE; j++)
    {
      float key = buckets[i][j];
      int k = j - 1;
      while (k >= 0 && buckets[i][k] > key)
      {
        buckets[i][k + 1] = buckets[i][k];
        k--;
      }
      buckets[i][k + 1] = key;
    }
  }

  // Concatenate the sorted buckets into the original array
  int k = 0;
  for (int i = 0; i < num_buckets; i++)
  {
    for (int j = 0; j < ARRAY_SIZE; j++)
    {
      if (buckets[i][j] != 0.0f)
      {
        arr[k] = buckets[i][j];
        k++;
      }
    }
  }
}

int main()
{
  float arr[ARRAY_SIZE] = {0.76f, 0.44f, 0.12f, 0.87f, 0.33f, 0.67f, 0.91f, 0.55f, 0.28f, 0.60f};
  int n = ARRAY_SIZE;

  printf("Before sorting:\n");
  printArray(arr, n);

  bucketSort(arr, n);

  printf("After sorting:\n");
  printArray(arr, n);

  return 0;
}