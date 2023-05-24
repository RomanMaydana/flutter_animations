import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

const _cardHeaderSize = 250.0;

class _MyHeader {
  _MyHeader(this.title, this.visible);

  final String title;
  final bool visible;
}

class BankScreen extends StatefulWidget {
  const BankScreen({super.key});

  @override
  State<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> {
  final headerNotifier = ValueNotifier<_MyHeader?>(null);
  final scrollNotifier = ValueNotifier(0.0);
  final scrollController = ScrollController();

  List<Transaction> transactionList = [
    Transaction('Juan Pérez', 100.50),
    Transaction('María Rodríguez', -75.20),
    Transaction('Carlos Gómez', -50.00),
    Transaction('Ana López', 120.80),
    Transaction('Pedro Martínez', 90.10),
    Transaction('Laura Hernández', -60.75),
    Transaction('José González', 85.30),
    Transaction('Sofía Silva', 70.90),
    Transaction('Diego Ramírez', -110.25),
    Transaction('Valentina Castro', 95.50),
    Transaction('Andrés Vargas', 45.60),
    Transaction('Carolina Cruz', -80.15),
    Transaction('Gabriel Mendoza', 65.40),
    Transaction('Fernanda Torres', -105.70),
    Transaction('Andrea Ríos', 55.00),
  ];

  void _onListen() {
    scrollNotifier.value = scrollController.offset;
  }

  @override
  void initState() {
    scrollController.addListener(_onListen);

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _refreshHeader(String title, bool visible, {String? lastOne}) {
    final headerValue = headerNotifier.value;
    final headerTitle = headerValue?.title ?? title;
    final headerVisible = headerValue?.visible ?? false;

    if (scrollController.offset > 0 &&
        (headerTitle != title || lastOne != null || headerVisible != visible)) {
      Future.microtask(() {
        if (!visible && lastOne != null) {
          headerNotifier.value = _MyHeader(lastOne, true);
        } else {
          headerNotifier.value = _MyHeader(title, visible);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          CustomScrollView(
            controller: scrollController,
            slivers: [
              ValueListenableBuilder<double>(
                  valueListenable: scrollNotifier,
                  builder: (context, snapshot, _) {
                    const space = _cardHeaderSize - kToolbarHeight;
                    final percent = lerpDouble(
                        0.0, -pi / 2, (snapshot / space).clamp(0.0, 1.0))!;
                    final opacity = lerpDouble(
                        1.0, 0.0, (snapshot / space).clamp(0.0, 1.0))!;
                    return SliverAppBar(
                      centerTitle: false,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                      title: const Text(
                        '\$26,710',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w300),
                      ),
                      expandedHeight: _cardHeaderSize,
                      stretch: true,
                      flexibleSpace: FlexibleSpaceBar(
                        stretchModes: const [StretchMode.blurBackground],
                        background: Padding(
                          padding: const EdgeInsets.only(top: kToolbarHeight),
                          child: Center(
                              child: Opacity(
                            opacity: opacity,
                            child: Transform(
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.003)
                                ..rotateX(percent),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                padding:
                                    const EdgeInsets.only(top: 20, left: 20),
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white30,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: const EdgeInsets.all(16),
                                    width: 200,
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.credit_card,
                                          size: 40,
                                        ),
                                        Spacer(),
                                        Text('\$23.324',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold)),
                                        Text('Main Account')
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        // color: Colors.white30,
                                        border: Border.all(
                                            color: Colors.white, width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: const EdgeInsets.all(16),
                                    width: 120,
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.festival_rounded,
                                          size: 40,
                                        ),
                                        Spacer(),
                                        Text('\$4.20',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold)),
                                        Text('Vacation')
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        // color: Colors.white30,
                                        border: Border.all(
                                            color: Colors.white, width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: const EdgeInsets.all(16),
                                    width: 150,
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.flash_on_outlined,
                                          color: Colors.yellow,
                                          size: 40,
                                        ),
                                        Spacer(),
                                        Text('\$84.20',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold)),
                                        Text('Buy Tesla')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                        ),
                      ),
                    );
                  }),
              ...[
                SliverPersistentHeader(
                    delegate: _MyHeaderTitle('Latest Transaction',
                        (visible) => _refreshHeader('May', visible))),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white24,
                              radius: 15,
                              child: Image.network(
                                  'https://cdn.icon-icons.com/icons2/3106/PNG/512/person_avatar_account_user_icon_191606.png'),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transactionList[index].personName,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'Recharge cards',
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                            trailing: Text(
                              transactionList[index].amount > 0
                                  ? '\$${transactionList[index].amount}'
                                  : '-\$${transactionList[index].amount.abs()}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: transactionList[index].amount > 0
                                      ? Colors.lightGreenAccent
                                      : null),
                            ),
                          ),
                      childCount: transactionList.length),
                )
              ],
              ...[
                SliverPersistentHeader(
                    delegate: _MyHeaderTitle(
                        'May 23',
                        (visible) =>
                            _refreshHeader('April', visible, lastOne: 'May'))),
                SliverList(
                  delegate:SliverChildBuilderDelegate(
                      (context, index) => ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white24,
                              radius: 15,
                              child: Image.network(
                                  'https://cdn.icon-icons.com/icons2/3106/PNG/512/person_avatar_account_user_icon_191606.png'),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transactionList[index].personName,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'Recharge cards',
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                            trailing: Text(
                              transactionList[index].amount > 0
                                  ? '\$${transactionList[index].amount}'
                                  : '-\$${transactionList[index].amount.abs()}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: transactionList[index].amount > 0
                                      ? Colors.lightGreenAccent
                                      : null),
                            ),
                          ),
                      childCount: transactionList.length),
                )
              ],
            ],
          ),
          ValueListenableBuilder<_MyHeader?>(
              valueListenable: headerNotifier,
              builder: (context, snapshot, _) {
                final visible = snapshot?.visible ?? false;
                final title = snapshot?.title ?? '';

                return Positioned(
                  left: 15,
                  top: 0,
                  right: 0,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    layoutBuilder: (currentChild, previousChildren) {
                      return Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          ...previousChildren,
                          if (currentChild != null) currentChild
                        ],
                      );
                    },
                    child: visible
                        ? Container(
                            key: Key(title),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                                color: Colors.black.withOpacity(0.7)),
                            child: Text(
                              title,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          )
                        : const SizedBox.shrink(),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          sizeFactor: animation,
                          child: child,
                        ),
                      );
                    },
                  ),
                );
              }),
          const Positioned(
              right: 10,
              top: 0,
              child: CircleAvatar(
                backgroundColor: Colors.white60,
                child: Icon(Icons.compare_arrows_sharp),
              ))
        ],
      )),
    );
  }
}

const MAX_HEADER_TITLE_HEIGHT = 55.0;
typedef OnHeaderChanged = void Function(bool visible);

class _MyHeaderTitle extends SliverPersistentHeaderDelegate {
  _MyHeaderTitle(
    this.title,
    this.onHeaderChanged,
  );

  final OnHeaderChanged onHeaderChanged;
  final String title;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    onHeaderChanged(shrinkOffset > 0);
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  @override
  double get maxExtent => MAX_HEADER_TITLE_HEIGHT;

  @override
  double get minExtent => MAX_HEADER_TITLE_HEIGHT;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class Transaction {
  String personName;
  double amount;

  Transaction(this.personName, this.amount);
}
