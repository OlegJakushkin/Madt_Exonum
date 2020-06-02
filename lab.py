from madt_lib.network import Network, Overlay


def main():
    net = Network('15.0.0.0/8')
    node1 = net.create_node('Node0', image='madt/exonum', ports={'6331/tcp': 6331, '8000/tcp': 8000, '8008/tcp': 8008}, privileged=True)
    node2 = net.create_node('Node1', image='madt/exonum', ports={'6332/tcp': 6332, '8001/tcp': 8001}, privileged=True)
    node3 = net.create_node('Node2', image='madt/exonum', ports={'6333/tcp': 6334, '8002/tcp': 8002}, privileged=True)
    node4 = net.create_node('Node3', image='madt/exonum', ports={'6335/tcp': 6335, '8003/tcp': 8003}, privileged=True)
    net.create_subnet('net', (node1, node2, node3, node4))

    net.configure(verbose=True)
    net.render('../../labs/exonum', verbose=True)

if __name__ == "__main__":
    main()