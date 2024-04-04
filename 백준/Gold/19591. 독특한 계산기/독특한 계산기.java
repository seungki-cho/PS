import java.io.*;
import java.util.*;

/**
 * Main
 */
public class Main {

    static long ans;
    static ArrayDeque<String> list;

    public String trim(String s) {

        int idx = 0;
        if (s.length() == 1) {
            return s;
        }
        if (s.charAt(0) == '-')
            idx++;
        while (idx < s.length() && s.charAt(idx) == '0') {
            // System.out.println("!");
            idx++;
        }
        if (idx == s.length())
            return "0";
        if (s.charAt(0) == '-') {
            return "-" + s.substring(idx, s.length());
        }
        return s.substring(idx, s.length());

    }

    public long cal(long n1, long n2, String op) {
        switch (op.charAt(0)) {
            case '+':
                return n1 + n2;
            case '-':
                return n1 - n2;
            case '/':
                return n1 / n2;
            case '*':
                return n1 * n2;
            default:
                return 0;
        }
    }

    public void solve() {
        String n1, n2, op1, n3, n4, op2;
        while (list.size() > 1) {
            // System.out.println(list.size());
            // System.out.println(list);
            if (list.size() == 3) {
                n1 = list.pollFirst();
                op1 = list.pollFirst();
                n2 = list.pollFirst();
                long ret1 = cal(Long.parseLong(n1), Long.parseLong(n2), op1);
                list.addFirst(Long.toString(ret1));
                continue;
            }
            n1 = list.pollFirst();
            op1 = list.pollFirst();
            n2 = list.pollFirst();
            n4 = list.pollLast();
            op2 = list.pollLast();
            if (!list.isEmpty())
                n3 = list.pollLast();
            else
                n3 = n2;
            long ret1 = cal(Long.parseLong(n1), Long.parseLong(n2), op1);
            long ret2 = cal(Long.parseLong(n3), Long.parseLong(n4), op2);
            if (p(op1) == p(op2)) {
                if (ret2 > ret1) {
                    if (!list.isEmpty())
                        list.addFirst(n2);
                    list.addFirst(op1);
                    list.addFirst(n1);
                    list.addLast(Long.toString(ret2));
                } else {
                    if (!list.isEmpty())
                        list.addLast(n3);
                    list.addLast(op2);
                    list.addLast(n4);
                    list.addFirst(Long.toString(ret1));
                }
            } else if (p(op1) > p(op2)) {
                if (!list.isEmpty())
                    list.addLast(n3);
                list.addLast(op2);
                list.addLast(n4);
                list.addFirst(Long.toString(ret1));
            } else {
                if (!list.isEmpty())
                    list.addFirst(n2);
                list.addFirst(op1);
                list.addFirst(n1);
                list.addLast(Long.toString(ret2));
            }
        }
        System.out.println(list.pollFirst());
    }

    public int p(String op1) {
        switch (op1.charAt(0)) {
            case '-':
            case '+':
                return 0;
            default:
                return 1;

        }

    }

    public void solution() throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String s = br.readLine();

        list = new ArrayDeque<>();
        int idx = 0;

        if (s.charAt(0) == '-') {
            while (++idx < s.length() && Character.isDigit(s.charAt(idx))) {
            }
            list.add(trim(s.substring(0, idx)));
        }
        while (idx < s.length()) {
            int start = idx;
            int end = start;

            if (!Character.isDigit(s.charAt(end))) {
                end++;
            } else {
                while (++end < s.length() && Character.isDigit(s.charAt(end))) {
                }

            }
            // System.out.println(start + " " + end);
            list.add(trim(s.substring(start, end)));
            idx = end;
        }
        // for (String string : list) {
        // System.out.println(string);
        // }
        solve();
    }

    public static void main(String[] args) throws Exception {
        new Main().solution();
    }
}