import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.StringTokenizer;

public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        int M = Integer.parseInt(st.nextToken());
        int[][] li = new int[N][M];
        boolean[][][] v = new boolean[N][M][4];

        for(int i = 0; i < N; i++) {
            st = new StringTokenizer(br.readLine());
            for(int j = 0; j < M; j++){
                li[i][j] = Integer.parseInt(st.nextToken());
            }
        }
        st = new StringTokenizer(br.readLine());
        int si = Integer.parseInt(st.nextToken())-1;
        int sj = Integer.parseInt(st.nextToken())-1;
        int sd = Integer.parseInt(st.nextToken())-1;

        st = new StringTokenizer(br.readLine());
        int ei = Integer.parseInt(st.nextToken())-1;
        int ej = Integer.parseInt(st.nextToken())-1;
        int ed = Integer.parseInt(st.nextToken())-1;

        LinkedList<Pair> q = new LinkedList<>();
        v[si][sj][sd] = true;

        q.add(new Pair(si, sj, 0, sd));

        int[] dx = {0,0,1,-1};
        int[] dy = {1,-1,0,0};
        int[] da = {3,2,0,1};
        int[] db = {2,3,1,0};
        while (q.size() > 0) {
            Pair t = q.poll();
            if (t.i == ei && t.j == ej && t.d == ed) {
                System.out.println(t.w);
                return;
            }
            for(int i = 1; i <= 3; i++) {
                int ni = t.i + dx[t.d]*i;
                int nj = t.j + dy[t.d]*i;

                if(ni < 0 || nj < 0 || ni >= N || nj >= M) { continue; }
                if(li[ni][nj] == 1) { break; }
                if(v[ni][nj][t.d]) { continue; }

                v[ni][nj][t.d] = true;
                q.add(new Pair(ni, nj, t.w+1, t.d));
            }
            if(!v[t.i][t.j][da[t.d]]){
                v[t.i][t.j][da[t.d]] = true;
                q.add(new Pair(t.i, t.j, t.w+1, da[t.d]));
            }
            if(!v[t.i][t.j][db[t.d]]){
                v[t.i][t.j][db[t.d]] = true;
                q.add(new Pair(t.i, t.j, t.w+1, db[t.d]));
            }
        }
    }
    static class Pair {
        int i;
        int j;
        int w;
        int d;
        Pair(int i, int j, int w, int d) {
            this.i = i;
            this.j = j;
            this.w = w;
            this.d = d;
        }
    }
}
