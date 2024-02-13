import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    static int[] ix = {0,0,1,-1};
    static int[] iy = {1,-1,0,0};
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringBuilder sb = new StringBuilder();
        int N = Integer.parseInt(br.readLine());
        int[][] li = new int[N][N];

        HashSet<Integer>[] lovedSet = new HashSet[N*N+1];

        for(int t = 0; t < N*N; t++) {
            StringTokenizer st = new StringTokenizer(br.readLine());
            int lover = Integer.parseInt(st.nextToken());
            lovedSet[lover] = new HashSet<>();

            for(int i = 0; i < 4; i++) {
                lovedSet[lover].add(Integer.parseInt(st.nextToken()));
            }

            int emptyMax = -1, lovedMax = -1;
            int mx = 0, my = 0;

            for(int i = 0; i < N; i++) {
                for (int j = 0; j < N; j++) {
                    if (li[i][j] != 0) { continue; }
                    int empty = 0, loved = 0;

                    for(int k = 0; k < ix.length; k++) {
                        int X = i + ix[k];
                        int Y = j + iy[k];

                        if (X < 0 || Y < 0 || X >= N || Y >= N) { continue; }

                        empty += li[X][Y] == 0 ? 1 : 0;
                        loved += lovedSet[lover].contains(li[X][Y]) ? 1 : 0;
                    }
                    if (loved > lovedMax || (lovedMax == loved && empty > emptyMax)) {
                        mx = i;
                        my = j;
                        lovedMax = loved;
                        emptyMax = empty;
                    }
                }
            }
            li[mx][my] = lover;
        }
        int ans = 0;

        for(int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                int loved = 0;
                for(int k = 0; k < ix.length; k++) {
                    int X = i + ix[k];
                    int Y = j + iy[k];

                    if (X < 0 || Y < 0 || X >= N || Y >= N) { continue; }

                    loved += lovedSet[li[i][j]].contains(li[X][Y]) ? 1 : 0;
                }
                ans += (int) (Math.pow(10, loved) / 10);
            }
        }
        
        System.out.println(ans);
    }
}