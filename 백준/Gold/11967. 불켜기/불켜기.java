import java.util.*;
import java.io.*;

public class Main {
    public static void main(String[] args) throws Exception{
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        int M = Integer.parseInt(st.nextToken());

        boolean[][] isv = new boolean[N][N];
        boolean[][] cango = new boolean[N][N];
        HashSet<Integer> hubo = new HashSet<>();
        
        ArrayList<Pair>[][] link = new ArrayList[N][N];
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                link[i][j] = new ArrayList<>();
            }
        }

        for (int i = 0; i < M; i++) {
            st = new StringTokenizer(br.readLine());

            int x = Integer.parseInt(st.nextToken())-1;
            int y = Integer.parseInt(st.nextToken())-1;
            int a = Integer.parseInt(st.nextToken())-1;
            int b = Integer.parseInt(st.nextToken())-1;
            link[x][y].add(new Pair(a, b));
        }

        ArrayDeque<Pair> q = new ArrayDeque<>();
        int[] ix = new int[]{0, 0, 1, -1};
        int[] iy = new int[]{1, -1, 0, 0};
        q.add(new Pair(0, 0));
        isv[0][0] = true;
        cango[0][0] = true;

        while (!q.isEmpty()) {
            Pair p = q.poll();
            for (int i = 0; i < link[p.x][p.y].size(); i++) {
                Pair go = link[p.x][p.y].get(i);
                if (cango[go.x][go.y] || isv[go.x][go.y]) continue;

                cango[go.x][go.y] = true;
                if (hubo.contains(go.x * 1000 + go.y)) {
                    q.add(go);
                }
            }
            
            for (int i = 0; i < 4; i++) {
                int x = p.x + ix[i];
                int y = p.y + iy[i];
                if (x < 0 || y < 0 || x >= N || y >= N || isv[x][y]) continue;
                if (cango[x][y]) {
                    q.add(new Pair(x, y));
                    isv[x][y] = true;
                } else {
                    hubo.add(x * 1000 + y);
                }
            }
        }



        int ans = 0;
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                if (cango[i][j]) {
                    ans += 1;
                }
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
        @Override
        public String toString() {
            return "Pair{" +
                    "x=" + x +
                    ", y=" + y +
                    '}';
        }
    }
}