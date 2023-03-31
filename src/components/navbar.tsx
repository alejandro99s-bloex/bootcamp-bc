import styles from '@/styles/components/Navbar.module.css'
import { ConnectButton } from '@rainbow-me/rainbowkit';
import Link from "next/link";

type NavbarProps = {
    page: string;
};

const Navbar = ({ page }: NavbarProps) => {
    return <>
        <div className={styles.navbar}>
            <div className={styles.navbar_container}>
                <img src="/logos/bancolombia.png" alt="bancolombia" height={60} />
                <h2 className={styles.navbar_container_title}>Leasing inmobiliario Bancolombia</h2>
                <Link
                    href={`${page == "index" ? "/profile" : "/"}`}
                    className={styles.navbar_container_myProfile}
                >
                    {`${page== "index" ? "Mi perfil" : "Inicio"}`}
                </Link>
                <ConnectButton />
            </div>
        </div>
    </>
}
export default Navbar