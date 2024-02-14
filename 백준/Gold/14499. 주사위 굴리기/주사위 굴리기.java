import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.StringTokenizer;

enum Direction {
    RIGHT, LEFT, UP, DOWN;
}

class Cube {
    int up, down, left, right, top, bottom;

    Cube() {
        this.up = this.down = this.left = this.right = this.top = this.bottom = 0;
    }
}

class Dice {
    private Cube cube;
    private int[][] li;
    private int x, y;
    private StringBuilder sb = new StringBuilder();

    Dice(int[][] li, int X, int Y) {
        this.li = li;
        this.x = X;
        this.y = Y;
        this.cube = new Cube();
    }

    private void turnUp() {
        Cube newCube = new Cube();
        if (li[x][y] == 0) {
            newCube.bottom = cube.up;
            li[x][y] = cube.up;
        } else {
            newCube.bottom = li[x][y];
            li[x][y] = 0;
        }

        newCube.left = cube.left;
        newCube.right = cube.right;
        newCube.down = cube.bottom;
        newCube.up = cube.top;
        newCube.top = cube.down;
        cube = newCube;
    }

    private void turnDown() {
        Cube newCube = new Cube();
        if (li[x][y] == 0) {
            newCube.bottom = cube.down;
            li[x][y] = cube.down;
        } else {
            newCube.bottom = li[x][y];
            li[x][y] = 0;
        }

        newCube.left = cube.left;
        newCube.right = cube.right;
        newCube.down = cube.top;
        newCube.up = cube.bottom;
        newCube.top = cube.up;
        cube = newCube;
    }

    private void turnLeft() {
        Cube newCube = new Cube();
        if (li[x][y] == 0) {
            newCube.bottom = cube.left;
            li[x][y] = cube.left;
        } else {
            newCube.bottom = li[x][y];
            li[x][y] = 0;
        }

        newCube.left = cube.top;
        newCube.right = cube.bottom;
        newCube.down = cube.down;
        newCube.up = cube.up;
        newCube.top = cube.right;
        cube = newCube;
    }

    private void turnRight() {
        Cube newCube = new Cube();
        if (li[x][y] == 0) {
            newCube.bottom = cube.right;
            li[x][y] = cube.right;
        } else {
            newCube.bottom = li[x][y];
            li[x][y] = 0;
        }

        newCube.left = cube.bottom;
        newCube.right = cube.top;
        newCube.down = cube.down;
        newCube.up = cube.up;
        newCube.top = cube.left;
        cube = newCube;
    }

    void roll(Direction direction) {
        switch (direction) {
            case RIGHT:
                if (y + 1 < li[0].length) {
                    y += 1;
                    turnRight();
                } else {
                    return;
                }
                break;
            case LEFT:
                if (y - 1 >= 0) {
                    y -= 1;
                    turnLeft();
                } else {
                    return;
                }
                break;
            case UP:
                if (x - 1 >= 0) {
                    x -= 1;
                    turnUp();
                } else {
                    return;
                }
                break;
            case DOWN:
                if (x + 1 < li.length) {
                    x += 1;
                    turnDown();
                } else {
                    return;
                }
                break;
        }
        sb.append(cube.top).append("\n");
    }
    void print() {
        System.out.println(sb);
    }
}

public class Main {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());

        int N = Integer.parseInt(st.nextToken());
        int M = Integer.parseInt(st.nextToken());
        int x = Integer.parseInt(st.nextToken());
        int y = Integer.parseInt(st.nextToken());
        int K = Integer.parseInt(st.nextToken());

        int[][] li = new int[N][M];
        for (int i = 0; i < N; i++) {
            st = new StringTokenizer(br.readLine());
            for (int j = 0; j < M; j++) {
                li[i][j] = Integer.parseInt(st.nextToken());
            }
        }

        Dice dice = new Dice(li, x, y);

        st = new StringTokenizer(br.readLine());
        for (int i = 0; i < K; i++) {
            int direction = Integer.parseInt(st.nextToken());
            switch (direction) {
                case 1:
                    dice.roll(Direction.RIGHT);
                    break;
                case 2:
                    dice.roll(Direction.LEFT);
                    break;
                case 3:
                    dice.roll(Direction.UP);
                    break;
                case 4:
                    dice.roll(Direction.DOWN);
                    break;
            }
        }
        dice.print();
    }
}