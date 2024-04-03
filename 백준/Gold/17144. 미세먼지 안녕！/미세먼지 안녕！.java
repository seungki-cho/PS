import java.util.*;
import java.io.*;

public class Main {
    static int R, C, T;
    static int[][] li;
    static int[][] plus;
    static int[] dx = {0, 0, 1, -1};
    static int[] dy = {1, -1, 0, 0};
    static int xi, yi;


    public static void main(String[] args) throws Exception{
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        R = Integer.parseInt(st.nextToken());
        C = Integer.parseInt(st.nextToken());
        T = Integer.parseInt(st.nextToken());

        li = new int[R][C];
        plus = new int[R][C];

        for (int i = 0; i < R; i++) {
            st = new StringTokenizer(br.readLine());
            for (int j = 0; j < C; j++) {
                li[i][j] = Integer.parseInt(st.nextToken());
                if (li[i][j] == -1) {
                    xi = i;
                    yi = j;
                }
            }
        }

        for (int t = 0; t < T; t++) {
            diffusion();
            samsung();
        }

        int sum = 0;
        for (int i = 0; i < R; i++) {
            for (int j = 0; j < C; j++) {
                sum += li[i][j];
            }
        }

        System.out.println(sum + 2);
    }

    static void diffusion() {
        plus = new int[R][C];

        for (int i = 0; i < R; i++) {
            for (int j = 0; j < C; j++) {
                if (li[i][j] > 0) {
                    int count = 0;
                    for (int k = 0; k < 4; k++) {
                        int nx = i + dx[k];
                        int ny = j + dy[k];
                        if (nx >= 0 && nx < R && ny >= 0 && ny < C && li[nx][ny] != -1) {
                            count++;
                            plus[nx][ny] += li[i][j] / 5;
                        }
                    }
                    li[i][j] -= (li[i][j] / 5) * count;
                }
            }
        }

        for (int i = 0; i < R; i++) {
            for (int j = 0; j < C; j++) {
                li[i][j] += plus[i][j];
            }
        }
    }

    static void samsung() {
        int x = xi - 1;
        int y = yi;
        LinkedList<Integer> q = new LinkedList<>();

        for (int j = 1; j < C; j++) {
            q.add(li[x][j]);
        }
        for (int i = x - 1; i >= 0; i--) {
            q.add(li[i][C - 1]);
        }
        for (int j = C - 2; j >= 0; j--) {
            q.add(li[0][j]);
        }
        for (int i = 1; i < x; i++) {
            q.add(li[i][0]);
        }
        q.remove(q.size() - 1);
        q.add(0, 0);

        for (int j = 1; j < C; j++) {
            li[x][j] = q.removeFirst();
        }
        for (int i = x - 1; i >= 0; i--) {
            li[i][C - 1] = q.removeFirst();
        }
        for (int j = C - 2; j >= 0; j--) {
            li[0][j] = q.removeFirst();
        }
        for (int i = 1; i < x; i++) {
            li[i][0] = q.removeFirst();
        }

        x = xi;
        y = yi;
        q = new LinkedList<>();

        for (int j = 1; j < C; j++) {
            q.add(li[x][j]);
        }
        for (int i = x + 1; i < R; i++) {
            q.add(li[i][C - 1]);
        }
        for (int j = C - 2; j >= 0; j--) {
            q.add(li[R - 1][j]);
        }
        for (int i = R - 2; i > x; i--) {
            q.add(li[i][0]);
        }

        q.removeLast();
        q.addFirst(0);

        for (int j = 1; j < C; j++) {
            li[x][j] = q.removeFirst();
        }
        for (int i = x + 1; i < R; i++) {
            li[i][C - 1] = q.removeFirst();
        }
        for (int j = C - 2; j >= 0; j--) {
            li[R - 1][j] = q.removeFirst();
        }
        for (int i = R - 2; i > x; i--) {
            li[i][0] = q.removeFirst();
        }
    }
}