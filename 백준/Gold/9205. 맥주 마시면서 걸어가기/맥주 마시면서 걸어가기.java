import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.security.Key;
import java.util.StringTokenizer;

public class Main {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        for (int t = 0, e = Integer.parseInt(br.readLine()); t < e; t++) {
            int N = Integer.parseInt(br.readLine()) + 2;
            Pair[] pairs = new Pair[N];
            boolean[][] li = new boolean[N][N];
            for (int i = 0; i < N; i++) {
                StringTokenizer st = new StringTokenizer(br.readLine());
                pairs[i] = new Pair(Integer.parseInt(st.nextToken()), Integer.parseInt(st.nextToken()));
            }

            for (int i = 0; i < N; i++)
                for (int j = i; j < N; j++)
                    li[i][j] = li[j][i] = pairs[i].canGo(pairs[j]);

            for (int k = 0; k < N; k++)
                for (int i = 0; i < N; i++)
                    for (int j = 0; j < N; j++)
                        li[i][j] |= li[i][k] && li[k][j];

            System.out.println(li[0][N-1] ? "happy" : "sad");
        }
    }
    static class Pair {
        int x; int y;
        public Pair(int x, int y) {
            this.x = x;
            this.y = y;
        }
        private int distanceTo(Pair p) {
            return Math.abs(x - p.x) + Math.abs(y - p.y);
        }
        boolean canGo(Pair p) {
            return distanceTo(p) <= 1000;
        }
    }
}