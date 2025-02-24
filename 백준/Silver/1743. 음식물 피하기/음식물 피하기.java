import java.io.*;
import java.util.*;

public class Main {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        int M = Integer.parseInt(st.nextToken());
        int K = Integer.parseInt(st.nextToken());
        boolean[][] isv = new boolean[N][M];
        boolean[][] ist = new boolean[N][M];

        for (int i = 0; i < K; i++) {
            st = new StringTokenizer(br.readLine());
            int a = Integer.parseInt(st.nextToken())-1;
            int b = Integer.parseInt(st.nextToken())-1;
            ist[a][b] = true;
        }

        int[] ix = new int[]{1, -1, 0, 0};
        int[] iy = new int[]{0, 0, 1, -1};
        int ans = 0;

        for (int i = 0; i < N; i++) {
            for (int j = 0; j < M; j++) {
                if (isv[i][j] || !ist[i][j]) continue;
                ArrayDeque<Pair> q = new ArrayDeque();
                q.add(new Pair(i, j));
                int local = 0;
                isv[i][j] = true;
                
                while (!q.isEmpty()) {
                    Pair p = q.poll();
                    local += 1;

                    for (int k = 0; k < 4; k++) {
                        int x = p.x + ix[k];
                        int y = p.y + iy[k];

                        if (x < 0 || y < 0 || x >= N || y >= M || isv[x][y] || !ist[x][y]) continue;
                        q.add(new Pair(x, y));
                        isv[x][y] = true;
                    }
                }

                ans = Math.max(local, ans);
            }
        }
        System.out.println(ans);
    }
    static class Pair {
        int x, y;
        public Pair(int x, int y) {
            this.x = x;
            this.y = y;
        }
    }
}