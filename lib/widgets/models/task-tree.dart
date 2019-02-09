import 'dart:collection';

import 'package:ui_kurs/types/data/task.dart';

class Node {
  Node({ this.parent, this.source });

  List<Node> children = [];
  Node parent;
  Task source;
  int depth = 0;
}

class FlatListWithDepths {
  FlatListWithDepths({ this.flatList, this.depths });

  List<Task> flatList = [];
  Map<Task, int> depths = Map();
}

List<Node> buildTreeAndGetRoots(List<Task> actualObjects) {
  Map lookup = Map<String, Node>();
  List rootNodes = List<Node>();

  for (final item in actualObjects) {
    Node ourNode = lookup[item.id];

    if (ourNode != null) {
        ourNode.source = item;
    } else {
        ourNode = Node(source: item);
        lookup.putIfAbsent(item.id, () => ourNode);
    }

    if (item.parentId == null) {
        rootNodes.add(ourNode);
    } else {
        Node parentNode = lookup[item.parentId];

        if (parentNode == null) {
            parentNode = Node();
            lookup.putIfAbsent(item.parentId, () => parentNode);
        }

        parentNode.children.add(ourNode);
        ourNode.parent = parentNode;
    }
  }

  // calculating depths
  for (final root in rootNodes) {
    Queue<Node> queue = Queue.from([root]);

    while (queue.length > 0) {
      Node current = queue.removeLast();
      if (current.parent != null) {
        current.depth = current.parent.depth + 1;
      }

      queue.addAll(current.children.reversed);
    }
  }

  return rootNodes;
}

FlatListWithDepths getFlatListWithDepths(List<Node> roots) {
  List<Task> flatList = [];
  Map<Task, int> depths = Map();

  for (final root in roots) {
    Queue<Node> queue = Queue.from([root]);

    while (queue.length > 0) {
      Node current = queue.removeLast();
      flatList.add(current.source);
      depths.putIfAbsent(current.source, () => current.depth);

      queue.addAll(current.children.reversed);
    }
  }

  return FlatListWithDepths(depths: depths, flatList: flatList);
}