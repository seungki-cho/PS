import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.StringTokenizer;

/**
 * Main
 */
public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        int M = Integer.parseInt(st.nextToken());
        int L = Integer.parseInt(st.nextToken());
        int K = Integer.parseInt(st.nextToken());

        int[][] li = new int[K][2];
        for(int i = 0; i < K; i++) {
            st = new StringTokenizer(br.readLine());
            li[i][0] = Integer.parseInt(st.nextToken());    
            li[i][1] = Integer.parseInt(st.nextToken()); 

        }
        int ans = 0;
        for(int i = 0; i < K; i++) {
            for(int j = 0; j < K; j++) {
                int local = 0;
                int minn = li[i][0];
                int minm = li[j][1];
                int maxn = minn + L;
                int maxm = minm + L;
                for(int k = 0; k < K; k++) {
                    if (li[k][0] >= minn && li[k][0] <= maxn && li[k][1] >= minm && li[k][1] <= maxm){
                        local++;
                    }
                }
                ans = Math.max(local, ans);
            }
            
        }
        System.out.println(K - ans);
    }
}