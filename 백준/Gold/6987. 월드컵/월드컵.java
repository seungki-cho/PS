import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    static int[][] li;
    static int[][] mu;
    static int[] dp;
    static ArrayList<ArrayList<Integer>> five = new ArrayList<>();
    static ArrayList<ArrayList<Integer>> four = new ArrayList<>();
    static ArrayList<ArrayList<Integer>> three = new ArrayList<>();
    static ArrayList<ArrayList<Integer>> two = new ArrayList<>();
    static ArrayList<Integer> tmp = new ArrayList<>();

    static void a5() {
        if (tmp.size() == 5) {
            five.add((ArrayList<Integer>) tmp.clone());
            return;
        }
        for(int i = 0; i < 5; i++) {
            if (!tmp.contains(i)) {
                tmp.add(i);
                a5();
                tmp.remove(tmp.size()-1);
            }
        }
    }
    static void a4() {
        if (tmp.size() == 4) {
            four.add((ArrayList<Integer>) tmp.clone());
            return;
        }
        for(int i = 0; i < 4; i++) {
            if (!tmp.contains(i)) {
                tmp.add(i);
                a4();
                tmp.remove(tmp.size()-1);
            }
        }
    }
    static void a3() {
        if (tmp.size() == 3) {
            three.add((ArrayList<Integer>) tmp.clone());
            return;
        }
        for(int i = 0; i < 3; i++) {
            if (!tmp.contains(i)) {
                tmp.add(i);
                a3();
                tmp.remove(tmp.size()-1);
            }
        }
    }
    static void a2() {
        if (tmp.size() == 2) {
            two.add((ArrayList<Integer>) tmp.clone());
            return;
        }
        for(int i = 0; i < 2; i++) {
            if (!tmp.contains(i)) {
                tmp.add(i);
                a2();
                tmp.remove(tmp.size()-1);
            }
        }
    }
    static  int c;
    static boolean find(int n) {
        if (n == 0) {
            return true;
        }
        if (n == 5) {
            int[] seungmupae = new int[5];
            int k = 0;
            if (li[n][0] + li[n][1] + li[n][2] > n) {
                return false;
            }
            for (int i = 0; i < li[n][0]; i++) {
                seungmupae[k++] = -1;
            }
            for (int i = 0; i < li[n][1]; i++) {
                seungmupae[k++] = 0;
            }
            for (int i = 0; i < li[n][2]; i++) {
                seungmupae[k++] = 1;
            }

            for (int i = 0; i < five.size(); i++) {
                ArrayList<Integer> seq = five.get(i);
                boolean isFail = false;
                for (int j = 0; j < 5; j++) {
                    int a = seq.get(j);
                    if (li[a][1 - seungmupae[j]] > 0) {

                    } else {
                        isFail = true;
                    }
                    li[a][1 - seungmupae[j]] -= 1;
                }
//                System.out.println(Arrays.deepToString(li) + isFail + seq + Arrays.toString(seungmupae) + "A" );

                if (!isFail && find(n-1)) {
                    return true;
                }

                for (int j = 0; j < 5; j++) {
                    int a = seq.get(j);
                    li[a][1 - seungmupae[j]] += 1;
                }
            }
        } else if (n == 4) {
            int[] seungmupae = new int[4];
            int k = 0;
            if (li[n][0] + li[n][1] + li[n][2] > n) {
                return false;
            }
            for (int i = 0; i < li[n][0]; i++) {
                seungmupae[k++] = -1;
            }
            for (int i = 0; i < li[n][1]; i++) {
                seungmupae[k++] = 0;
            }
            for (int i = 0; i < li[n][2]; i++) {
                seungmupae[k++] = 1;
            }

            for (int i = 0; i < four.size(); i++) {
                ArrayList<Integer> seq = four.get(i);
                boolean isFail = false;
                for (int j = 0; j < 4; j++) {
                    int a = seq.get(j);
                    if (li[a][1 - seungmupae[j]] > 0) {
                    } else {
                        isFail = true;
                    }
                    li[a][1 - seungmupae[j]] -= 1;
                }
                if (!isFail && find(n - 1)) {
                    return true;
                }
                for (int j = 0; j < 4; j++) {
                    int a = seq.get(j);
                    li[a][1 - seungmupae[j]] += 1;
                }
            }
        } else if (n == 3) {
            int[] seungmupae = new int[3];
            int k = 0;

            if (li[n][0] + li[n][1] + li[n][2] > n) {
                return false;
            }
            for (int i = 0; i < li[n][0]; i++) {
                seungmupae[k++] = -1;
            }
            for (int i = 0; i < li[n][1]; i++) {
                seungmupae[k++] = 0;
            }
            for (int i = 0; i < li[n][2]; i++) {
                seungmupae[k++] = 1;
            }

            for (int i = 0; i < three.size(); i++) {
                ArrayList<Integer> seq = three.get(i);
                boolean isFail = false;
                for (int j = 0; j < 3; j++) {
                    int a = seq.get(j);
                    if (li[a][1 - seungmupae[j]] > 0) {
                    }else {
                        isFail = true;
                    }
                    li[a][1 - seungmupae[j]] -= 1;
                }
                if (!isFail && find(n - 1)) {
                    return true;
                }
                for (int j = 0; j < 3; j++) {
                    int a = seq.get(j);
                    li[a][1 - seungmupae[j]] += 1;
                }
            }
        } else if (n == 2) {
            int[] seungmupae = new int[2];
            int k = 0;
            if (li[n][0] + li[n][1] + li[n][2] > n) {
                return false;
            }
            for (int i = 0; i < li[n][0]; i++) {
                seungmupae[k++] = -1;
            }
            for (int i = 0; i < li[n][1]; i++) {
                seungmupae[k++] = 0;
            }
            for (int i = 0; i < li[n][2]; i++) {
                seungmupae[k++] = 1;
            }

            for (int i = 0; i < two.size(); i++) {
                ArrayList<Integer> seq = two.get(i);
                boolean isFail = false;
                for (int j = 0; j < 2; j++) {
                    int a = seq.get(j);
                    if (li[a][1 - seungmupae[j]] > 0) {
                    } else {
                        isFail = true;
                    }
                    li[a][1 - seungmupae[j]] -= 1;
                }
                if (!isFail && find(n - 1)) {
                    return true;
                }
                for (int j = 0; j < 2; j++) {
                    int a = seq.get(j);
                    li[a][1 - seungmupae[j]] += 1;
                }
            }
        } else if (n == 1) {
            int[] seungmupae = new int[1];
            int k = 0;
            if (li[n][0] + li[n][1] + li[n][2] > n) {
                return false;
            }
            for (int i = 0; i < li[n][0]; i++) {
                seungmupae[k++] = -1;
            }
            for (int i = 0; i < li[n][1]; i++) {
                seungmupae[k++] = 0;
            }
            for (int i = 0; i < li[n][2]; i++) {
                seungmupae[k++] = 1;
            }
            li[0][1 - seungmupae[0]] -= 1;
            if (li[0][1 - seungmupae[0]] >= 0 && find(n - 1)) {
                return true;
            }
            li[0][1 - seungmupae[0]] += 1;
        }
        return false;
    }

    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        a5();
        a4();
        a3();
        a2();

        for(int t = 0; t < 4; t++) {
            li = new int[6][3];
            mu = new int[6][3];
            dp = new int[3];
            StringTokenizer st = new StringTokenizer(br.readLine());
            boolean isFail = false;
            for(int i = 0; i < 6; i++) {
                int sum = 0;
                for(int j = 0; j < 3; j++) {
                    li[i][j] = Integer.parseInt(st.nextToken());
                    dp[j] += li[i][j];
                    sum += li[i][j];
                }
                if (sum != 5) {
                    isFail = true;
                }
            }
            if (dp[0] + dp[1] + dp[2] != 30) {
                System.out.println(0);
                continue;
            }

            for(int i = 0; i < li.length; i++) {
                mu[i] = li[i].clone();
            }

            for(int i = 0; i < 6; i++) {
                int sum = 0;
                for(int j = 0; j < 3; j++) {
                    sum += li[i][j];
                }
                isFail |= sum != 5;
            }
            isFail |= dp[0] != dp[2];
            isFail |= !find(5);
            System.out.println(isFail ? 0 : 1);
        }
    }

}
/*
5 0 0
3 0 2
2 0 3
0 0 5
4 0 1
1 0 4

 */