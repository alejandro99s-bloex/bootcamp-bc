import styles from '@/styles/components/Navbar.module.css'
import { ConnectButton } from '@rainbow-me/rainbowkit';

const Navbar = () => {
    return <>
        <div className={styles.navbar}>
            <div className={styles.navbar_container}>
                <img src="/logos/bancolombia.png" alt="bancolombia" height={60} />
                <h1 className={styles.navbar_container_title}>Leasing inmobiliario Bancolombia</h1>
                <ConnectButton />
            </div>
        </div>
    </>
}
export default Navbar