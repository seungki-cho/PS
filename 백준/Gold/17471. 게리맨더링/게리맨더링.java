import com.sun.security.jgss.GSSUtil;

import java.util.*;
import java.io.*;

public class Main {
    static int N;
    static int[] value;
    static ArrayList<Integer>[] li;

    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        N = Integer.parseInt(br.readLine());
        StringTokenizer st = new StringTokenizer(br.readLine());
        value = new int[N];
        li = new ArrayList[N];

        for(int i = 0; i < N; i++) {
            value[i] = Integer.parseInt(st.nextToken());
        }
        for(int i = 0; i < N; i++) {
            st = new StringTokenizer(br.readLine());
            li[i] = new ArrayList<>();
            for(int j = 0, e = Integer.parseInt(st.nextToken()); j < e; j++) {
                li[i].add(Integer.parseInt(st.nextToken())-1);
            }
        }

        int ans = 123456789;

        for(int bit = 1, end = 1<<(N) - 1; bit < end; bit++) {
            boolean isFail = false;
            int local = 0;
            int counterBit = bit ^ ((1 << N) - 1);

            if (isLinked(bit) && isLinked(counterBit)) {
                for (int i = 0; i < N; i++) {
                    local += ((Integer.bitCount(bit & (1 << i)) == 1 ? value[i] : 0) - (Integer.bitCount(counterBit & (1 << i)) == 1 ? value[i] : 0));
                }
                ans = Math.min(Math.abs(local), ans);
            }
        }
        System.out.println(ans == 123456789 ? -1 : ans);
    }
    static boolean isLinked(int bit) {
        Queue<Integer> q = new ArrayDeque<Integer>(Arrays.asList(Integer.numberOfTrailingZeros(bit)));
        int count = 1;
        int isv = 1 << Integer.numberOfTrailingZeros(bit);

        while (!q.isEmpty() && count < Integer.bitCount(bit)) {
            int region = q.poll();
            for(int next: li[region]) {
                if (Integer.bitCount(isv & (1 << next)) == 0 && Integer.bitCount(bit & (1 << next)) == 1) {
                    q.add(next);
                    isv |= 1<<next;
                    count++;
                }
            }
        }
        return count == Integer.bitCount(bit);
    }
}