import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.StringTokenizer;

public class Solution {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringBuilder sb = new StringBuilder();
        for (int t = 1, T = Integer.parseInt(br.readLine()); t <= T; t++) {
            StringTokenizer st = new StringTokenizer(br.readLine());
            int N = Integer.parseInt(st.nextToken());
            int[][] li = new int[N][N];
            int inf = 123456789;
            for (int i = 0; i < N; i++)
                for (int j = 0; j < N; j++) {
                    int n = Integer.parseInt(st.nextToken());
                    li[i][j] = n == 0 ? inf : n;
                    li[i][j] = i == j ? 0 : li[i][j];
                }

            for (int k = 0; k < N; k++) {
                for (int i = 0; i < N; i++) {
                    for (int j = 0; j < N; j++) {
                        if (li[i][k] != inf && li[k][j] != inf) {
                            li[i][j] = Math.min(li[i][j], li[i][k] + li[k][j]);
                        }
                    }
                }
            }

            int ans = inf;
            for (int i = 0; i < N; i++) {
                ans = Math.min(ans, Arrays.stream(li[i]).sum());
            }
            sb.append("#" + t + " " + ans + "\n");
        }
        System.out.println(sb);
    }
}