import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = s2i(st.nextToken());
        int M = s2i(st.nextToken());
        int T = s2i(st.nextToken());
        int K = s2i(st.nextToken());

        int[] xs = new int[T];
        int[] ys = new int[T];

        for(int i = 0; i < T; i++) {
            st = new StringTokenizer(br.readLine());
            xs[i] = s2i(st.nextToken());
            ys[i] = s2i(st.nextToken());
        }

        int ans = 0;
        int ax = 0, ay = 0;
        int[] dx = {1, 1, -1, -1};
        int[] dy = {1, -1, 1, -1};

        for(int i = 0; i < T; i++) {
            for(int j = 0; j < T; j++) {
                for(int a = 0; a < 4; a++) {
                    int sx = xs[i], sy = ys[j];
                    int ex = sx + K*dx[a], ey = sy + K*dy[a];

                    if (ex < sx) {
                        int tmp = ex;
                        ex = sx;
                        sx = tmp;
                    }
                    if (ey < sy) {
                        int tmp = ey;
                        ey = sy;
                        sy = tmp;
                    }

                    if (sx < 0) {
                        sx = 0;
                        ex = K;
                    } else if (ex > N) {
                        sx = N-K;
                        ex = N;
                    }

                    if (sy < 0) {
                        sy = 0;
                        ey = K;
                    } else if (ey > M) {
                        sy = M-K;
                        ey = M;
                    }
                    int local = 0;

                    for (int k = 0; k < T; k++) {
                        if (xs[k] <= ex && xs[k] >= sx && ys[k] <= ey && ys[k] >= sy) {
                            local++;
                        }
                    }
                    if (ans < local) {
                        ans = local;
                        ax = sx;
                        ay = ey;
                    }

//                    if (ans <= local) {
//                        System.out.println(sx + " " + ey);
//                    }
                }
            }
        }

        System.out.println(ax + " " + ay);
        System.out.println(ans);
    }
    static int s2i(String s) { return Integer.parseInt(s); }
}
/*
10 10 3 10
10 10
10 9
1 1

3 5 3 3
1 1
2 1
2 2
 */