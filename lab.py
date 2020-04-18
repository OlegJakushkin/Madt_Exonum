from madt_lib.network import Network, Overlay


def main():
    net = Network('15.0.0.0/8')
    node_count = 5
    nodes = []
    for counter in range(node_count):
        port = 8000+counter
        node = net.create_node('Node'+str(counter), image='madt/exonum', ports={str(port) + "/tcp": port}, privileged=True)
        nodes.append(node)
    net.create_subnet('test net', nodes)

    net.configure(verbose=True)
    net.render('../../labs/exonum', verbose=True)

if __name__ == "__main__":
    main()