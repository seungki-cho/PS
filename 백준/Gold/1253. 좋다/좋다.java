import java.io.*;
import java.util.*;

public class Main {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        int N = Integer.parseInt(br.readLine());
        StringTokenizer st = new StringTokenizer(br.readLine());
        HashMap<Integer, HashSet<Integer>> set = new HashMap<>();
        int[] li = new int[N];

        for (int i = 0; i < N; i++) {
            li[i] = Integer.parseInt(st.nextToken());
        }

        Arrays.sort(li);
        int ans = 0;

        for (int i = 0; i < N; i++) {

            int l = 0;
            int r = N-1;

            while (l < r) {
                if (l == i) {
                    l += 1;
                    continue;
                }

                if (r == i) {
                    r -= 1;
                    continue;
                }

                int m = li[l] + li[r];

                if (m < li[i]) {
                    l += 1;
                } else if (m > li[i]){
                    r -= 1;
                } else{
                    ans += 1;
                    break;
                }
            }
        }

        System.out.println(ans);
    }
}