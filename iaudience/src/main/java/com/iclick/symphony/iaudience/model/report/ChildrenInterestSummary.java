package com.iclick.symphony.iaudience.model.report;

/**
 * Created by wenjie.sun on 2017/3/27.
 */

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * 孩子列表类
 */
public class ChildrenInterestSummary {
  private List list = new ArrayList();

  public int getSize() {return list.size();}

  public void addChildInterestSummary(InterestSummary interestSummary) {
    list.add(interestSummary);
  }

  // 拼接子兴趣标签的JSON字符串
  public String toString() {
    StringBuffer result = new StringBuffer("[");
    for (Iterator it = list.iterator(); it.hasNext();) {

      result.append(((InterestSummary)it.next()).toString()).append(",");
    }
    result.deleteCharAt(result.length() -1);
    result.append("]");
    return result.toString();
  }

  // 子兴趣标签排序
  public void sortChildrenInterestSummary() {
    // 对本层子兴趣标签进行排序
    // 可根据不同的排序属性，传入不同的比较器，这里传入ID比较器
//    Collections.sort(list, new NodeIDComparator());
    // 对每个节点的下一层节点进行排序
    for (Iterator it = list.iterator(); it.hasNext();) {
      ((InterestSummary) it.next()).sortChildrenInterestSummary();
    }
  }
}