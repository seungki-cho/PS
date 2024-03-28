import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayDeque;
import java.util.Queue;
import java.util.StringTokenizer;

public class Main {
    static int[] ix = new int[]{0, 0, 1, -1};
    static int[] iy = new int[]{1, -1, 0, 0};
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int R = Integer.parseInt(st.nextToken());
        int C = Integer.parseInt(st.nextToken());
        char[][] li = new char[R][C];
        int[][] flo = new int[R][C];
        Queue<Pair> fq = new ArrayDeque<>();
        Queue<Pair> q = new ArrayDeque<>();

        for (int i = 0; i < R; i++) {
            String line = br.readLine();
            for (int j = 0; j < C; j++) {
                li[i][j] = line.charAt(j);
                if (li[i][j] == '*'){
                    fq.add(new Pair(i, j, 0));
                    flo[i][j] = 0;
                }
                if (li[i][j] == 'S') q.add(new Pair(i, j, 0));
                flo[i][j] = 11111111;
            }
        }

        while (!fq.isEmpty()) {
            Pair p = fq.poll();
            for (int i = 0; i < 4; i++) {
                int x = p.x + ix[i];
                int y = p.y + iy[i];
                if (x < 0 || y < 0 || x >= R || y >= C || li[x][y] != '.' || li[x][y] == 'X' || flo[x][y] != 11111111) continue;
                flo[x][y] = p.w + 1;
                fq.add(new Pair(x, y, p.w + 1));
            }
        }
        boolean isv[][] = new boolean[R][C];

        while (!q.isEmpty()) {
            Pair p = q.poll();
            if (li[p.x][p.y] == 'D') {
                System.out.println(p.w);
                System.exit(0);
            }

            for (int i = 0; i < 4; i++) {
                int x = p.x + ix[i];
                int y = p.y + iy[i];
                if (x < 0 || y < 0 || x >= R || y >= C || isv[x][y] || li[x][y] == 'X' || flo[x][y] <= p.w+1) continue;
                isv[x][y] = true;
                q.add(new Pair(x, y, p.w + 1));
            }
        }
        System.out.println("KAKTUS");
    }
    static class Pair {
        int x; int y; int w;

        public Pair(int x, int y, int w) {
            this.x = x;
            this.y = y;
            this.w = w;
        }
    }
}