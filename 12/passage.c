#include <stdio.h>

#define MAX_EDGES 50
#define START 0
#define END 20

typedef struct {
  int a;
  int b;
} Edge;

int n_edges = 0;
Edge edges[MAX_EDGES];

typedef struct {
  int ns[MAX_EDGES];
  int n;
} Neighbors;

void read_edges(FILE* fp) {
  while (! feof(fp)) {
    fscanf(fp, "%d\t%d\n", &edges[n_edges].a, &edges[n_edges].b);
    ++n_edges;
  }
}

void neighbors_for(int node, Neighbors* out) {
  for (int i = 0; i < n_edges; ++i) {
    if (edges[i].a == node) {
      out->ns[out->n++] = edges[i].b;
    } else if (edges[i].b == node) {
      out->ns[out->n++] = edges[i].a;
    }
  }
}

void visit(int node, Neighbors n, Neighbors* out) {
  out->n = n.n;
  for (int i = 0; i < n.n; ++i) {
    out->ns[i] = n.ns[i];
  }
  out->ns[out->n++] = node;
}

int visited(int node, Neighbors n) {
  for (int i = 0; i < n.n; ++i) {
    if (node == n.ns[i]) {
      return 1;
    }
  }
  return 0;
}

int paths_from(int node, Neighbors seen) {
  if (END == node) return 1;
  Neighbors cs = {0};
  neighbors_for(node, &cs);
  int total = 0;
  for (int i = 0; i < cs.n; ++i) {
    int next = cs.ns[i];
    if (END < next || ! visited(next, seen)) {
      Neighbors next_seen = {0};
      visit(next, seen, &next_seen);
      total += paths_from(next, next_seen);
    }
  }
  return total;
}

int main(int argc, const char **argv) {
  FILE* fp = fopen(argv[1], "r");
  read_edges(fp);
  fclose(fp);

  Neighbors start_visited = {0};
  visit(START, start_visited, &start_visited);
  printf("Paths to finish: %d\n", paths_from(START, start_visited));
  return 0;
}
