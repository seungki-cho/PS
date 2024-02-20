import java.io.*;
import java.util.*;

public class Main {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        int M = Integer.parseInt(st.nextToken());
        int[][] li = new int[N][M];
        for(int i = 0; i < N; i++) {
            st = new StringTokenizer(br.readLine());
            for(int j = 0; j < M; j++) {
                li[i][j] = Integer.parseInt(st.nextToken());
            }
        }
        int[] ix = {0, 0, 1, -1};
        int[] iy = {1, -1, 0, 0};

        boolean isSuccess = true;
        int ans = 0;
        int count = 0;
        while (isSuccess) {
            isSuccess = false;
            boolean[][] isv = new boolean[N][M];
            boolean[][] isMelt = new boolean[N][M];

            Queue<Pair> q = new ArrayDeque<>();
            q.add(new Pair(0, 0));

            while (!q.isEmpty()) {
                Pair pair = q.poll();
                int x = pair.x;
                int y = pair.y;
                for (int k = 0; k < ix.length; k++) {
                    int X = x + ix[k];
                    int Y = y + iy[k];

                    if (X < 0 || Y < 0 || X >= N || Y >= M || isv[X][Y]) {
                        continue;
                    }
                    isv[X][Y] = true;
                    if (li[X][Y] == 1) {
                        isMelt[X][Y] = true;
                    } else {
                        q.add(new Pair(X, Y));
                    }
                }

            }

            for(int i = 0; i < N; i++) {
                for (int j = 0; j < M; j++) {
                    if (isMelt[i][j]) {
                        if (!isSuccess) { count = 0; }
                        li[i][j] = 0;
                        count++;
                        isSuccess = true;
                    }
                }
            }
            if (isSuccess) { ans++; }
        }
        System.out.println(ans);
        System.out.println(count);
    }
    static class Pair {
        int x;
        int y;
        Pair(int x, int y) {
            this.x = x;
            this.y = y;
        }
    }
}