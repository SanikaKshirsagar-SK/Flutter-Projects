import "dart:io";

void main() {
  int x = 12;
  for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 3; j++) {
      stdout.write("$x ");
    }
    x--;
    print("");
  }
}

// o/p

// 12 12 12 
// 11 11 11
// 10 10 10