import Head from 'next/head'
import { Inter } from 'next/font/google'
import styles from '@/styles/Home.module.css'
import Navbar from '@/components/navbar'
import { useEffect, useState } from 'react'
import { useAccount } from "wagmi";
import axios from 'axios';
import { User, HousesProps, MyHouse } from "../../types/index";
import Loading from '@/components/loading'
import HomeBody from '@/components/home'
import Popup from '@/components/modal'
import HousesProfile from '@/components/houses'
import { readContract, writeContract } from '@wagmi/core'
import contractInfo from "../../../contractInfo/contract.json";
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

const inter = Inter({ subsets: ['latin'] })

export default function Profile() {
    const { isConnected, address } = useAccount();
    const [user, setUser] = useState<User | undefined>(undefined);
    const [userExist, setUserExist] = useState(false);
    const [houses, setHouses] = useState<Array<HousesProps> | undefined>(undefined);
    const [isLoading, setIsLoading] = useState(true);
    const [showPopUp, setShowPopUp] = useState(false);
    const [myHouse, setMyHouse] = useState<MyHouse>({ tokenUri: "", description: "", buttonOk: "", buttonCancel: "", onCancel: () => { }, onAccept: () => { } });


    const myHouses = [
        {
            name: "Casa A",
            price: 120000000,
            amountPaid: 8000000
        },
        {
            name: "Casa B",
            price: 110000000,
            amountPaid: 10000000
        }
    ]

    const tryToBuy = (house: HousesProps, user: User) => {
        setShowPopUp(true)
        setMyHouse({
            tokenUri: house.tokenUri,
            description: `${house.name}: ${house.description}.\n¿Te gusta este inmueble?`,
            buttonOk: "Solicitar",
            buttonCancel: "Cancelar",
            onCancel: () => {
                console.log("canceled")
                setShowPopUp(false);
            },
            onAccept: () => {
                console.log("Leasing solicitado")
                setShowPopUp(false);
            }
        })
    }

    useEffect(() => {
        console.log(user, isConnected, address)
        if (user) return;
        if (!isConnected) return;
        if (address) {
            axios.get(`/api/user/?address=${address}`)
                .then(response => {
                    const userApi = response.data
                    setUserExist(userApi.message == "OK")
                    setUser(userApi.user);
                    axios.get(`/api/house/?address=${address}`)
                        .then(response => {
                            const housesApi = response.data
                            setHouses(housesApi.houses);
                            setIsLoading(false);
                        })
                        .catch(error => {
                            console.log("El error es: ", error.response.data.message)
                            setIsLoading(false);
                        });
                })
                .catch(error => {
                    setUserExist(false)
                    console.log("El error es: ", error.response.data.message)
                    setIsLoading(false);
                });
        }
    }, [address])

    const contribute = async (house: HousesProps, e: any) => {
        e.preventDefault()
        const amount = e.target[0].value;
        if (amount) {
            try {
                const { hash } = await writeContract({
                    mode: 'recklesslyUnprepared',
                    abi: contractInfo.abi,
                    address: contractInfo.address as `0x${string}`,
                    functionName: 'contribute',
                    args: [house.id],
                    overrides: {
                        value: amount,
                    },
                })
                console.log(hash);
            } catch (e) {
                toast.error('Oops! Ocurrio un error al realizar un aporte.');
                console.log("Error aportando: ", e)
            }
        }
    }

    const yieldHouse = async (house: HousesProps) => {
        try {
            const { hash } = await writeContract({
                mode: 'recklesslyUnprepared',
                abi: contractInfo.abi,
                address: contractInfo.address as `0x${string}`,
                functionName: 'yieldLeasingRigth',
                args: [house.id],
            })
            if (hash) {
                axios.post(`/api/house`, { id: house.id })
                    .then(response => {
                        console.log("se actualizo: ", response)
                    }).catch(e => console.log("Error al actualizar las houses"))
            }
            console.log(hash);
        } catch (e) {
            toast.error('Oops! Ocurrio un error liberando tu leasing.');
            console.log(e)
        }
    }
    return (
        <>
            <Head>
                <title>Create Next App</title>
                <meta name="description" content="Generated by create next app" />
                <meta name="viewport" content="width=device-width, initial-scale=1" />
                <link rel="icon" href="/favicon.ico" />
            </Head>
            <main className={styles.main}>
                <Loading loading={isLoading} />
                <Popup show={showPopUp} myHouse={myHouse} />
                <Navbar page={"profile"} />
                {!isLoading && (userExist && <div className={styles.main_body}>
                    <h2>Mis inmuebles</h2>
                    <HousesProfile houses={houses} contribute={contribute} yieldHouse={yieldHouse} />
                </div>)}

            </main>
        </>
    )
}
