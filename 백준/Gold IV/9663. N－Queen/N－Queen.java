import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    static boolean[] row;
    static boolean[] col;
    static boolean[] fdig;
    static boolean[] odig;
    static int ans = 0;
    static int N;

    static void find(int X) {
        if (X == N-1) { ans++; return; }

        for (int y = 0; y < N; y++) {
            int x = X+1;
            if (row[x] | col[y] | fdig[x + y] | odig[y - x + N - 1]) { continue; }

            row[x] = col[y] = fdig[x + y] = odig[y - x + N - 1] = true;
            find(x);
            row[x] = col[y] = fdig[x + y] = odig[y - x + N - 1] = false;
        }
    }

    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        N = Integer.parseInt(br.readLine());
        row = new boolean[N];
        col = new boolean[N];
        fdig = new boolean[N * 2 - 1];
        odig = new boolean[N * 2 - 1];
        find(-1);
        System.out.println(ans);
    }
}