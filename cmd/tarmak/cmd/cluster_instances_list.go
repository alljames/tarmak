package cmd

import (
	"os"

	"github.com/Sirupsen/logrus"
	"github.com/spf13/cobra"

	"github.com/jetstack/tarmak/pkg/tarmak"
	"github.com/jetstack/tarmak/pkg/tarmak/utils"
)

var clusterInstancesListCmd = &cobra.Command{
	Use:   "list",
	Short: "list nodes of the cluster",
	Run: func(cmd *cobra.Command, args []string) {
		t := tarmak.New(cmd)
		hosts, err := t.Cluster().ListHosts()
		if err != nil {
			logrus.Fatal(err)
		}

		varMaps := make([]map[string]string, 0)
		for _, host := range hosts {
			varMaps = append(varMaps, host.Parameters())
		}
		utils.ListParameters(os.Stdout, []string{"id", "hostname", "roles"}, varMaps)
	},
}

func init() {
	clusterInstancesCmd.AddCommand(clusterInstancesListCmd)
}