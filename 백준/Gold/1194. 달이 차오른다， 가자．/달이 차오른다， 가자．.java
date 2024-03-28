import java.io.*;
import java.util.*;


//메모리 14328KB	시간 112ms

public class Main {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        int M = Integer.parseInt(st.nextToken());
        char[][] li = new char[N][M];
        int sx = 0;
        int sy = 0;
        int[] ix = new int[]{0, 0, 1, -1};
        int[] iy = new int[]{1, -1, 0, 0};

        for (int i = 0; i < N; i++) {
            String line = br.readLine();
            for (int j = 0; j < M; j++) {
                li[i][j] = line.charAt(j);
                if(li[i][j] == '0') {
                    sx = i; sy = j;
                }
            }
        }

        boolean[][][] isv = new boolean[64][N][M];
        ArrayDeque<Pair> q = new ArrayDeque<>();
        q.add(new Pair(sx, sy, 0, 0));

        boolean isFind = false;
        while (!q.isEmpty()) {
            Pair p = q.poll();
            if (li[p.x][p.y] == '1') {
                System.out.println(p.w);
                isFind = true;
                break;
            }
            if (li[p.x][p.y] >= 'a' && li[p.x][p.y] <= 'f')
                p.bit |= (1 << (li[p.x][p.y] - 'a'));

            for (int i = 0; i < 4; i++) {
                int x = p.x + ix[i];
                int y = p.y + iy[i];
                if (x < 0 || x >= N || y < 0 || y >= M || li[x][y] == '#' || isv[p.bit][x][y]) continue;
                if (li[x][y] >= 'A' && li[x][y] <= 'F' && (p.bit & (1 << (li[x][y] - 'A'))) == 0)  continue;

                isv[p.bit][x][y] = true;
                q.add(new Pair(x, y, p.w + 1, p.bit));
            }
        }
        if (!isFind)
            System.out.println(-1);
    }
    static class Pair {
        int x; int y; int w; int bit;
        public Pair(int x, int y, int w, int bit) {
            this.x = x;
            this.y = y;
            this.w = w;
            this.bit = bit;
        }
    }
}