import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.StringTokenizer;

public class Main {
    static int bs(ArrayList<Integer> li, int l, int r, int target) {
        while (l < r) {
            int m = (l + r) / 2;
            if (target > li.get(m)) {
                l = m+1;
            } else {
                r = m;
            }
        }

        return l;
    }
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        int N = Integer.parseInt(br.readLine());
        int[] li = new int[N];
        
        StringTokenizer st = new StringTokenizer(br.readLine());

        for(int i = 0; i < N; i++) {
            li[i] = Integer.parseInt(st.nextToken());
        }
        
        if (N == 1) {
            System.out.println(1);
            return;
        }
        ArrayList<Integer> dp = new ArrayList<>();
        dp.add(li[0]);
        for(int i = 1; i < N; i++) {
            if (dp.get(dp.size()-1) < li[i]) {
                dp.add(li[i]);
                continue;
            }
            int idx = bs(dp, 0, dp.size()-1, li[i]);
            dp.set(idx, li[i]);
        }
        System.out.println(N-dp.size());
    }
}